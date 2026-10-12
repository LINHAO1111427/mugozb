// Run after the administrator completes the local first-login acknowledgement.
const { chromium } = require('./private/browser/node_modules/playwright-core');
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const { isDeepStrictEqual } = require('node:util');
const root = __dirname;
const base = 'http://127.0.0.1:18089';

(async () => {
  const env = Object.fromEntries(fs.readFileSync(path.join(root, '.env'), 'utf8').trim().split(/\r?\n/).map(l => {
    const at = l.indexOf('='); return [l.slice(0, at), l.slice(at + 1)];
  }));
  const response = await fetch(base + '/api/v1/auth/login', {
    method: 'POST', headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email: 'admin@statekit.local', password: env.ADMIN_PASSWORD })
  });
  assert(response.ok);
  const { data: session } = await response.json();
  const api = async (url, method = 'GET', body) => {
    const r = await fetch(base + url, {method, headers: {
      Authorization: 'Bearer ' + session.access_token, 'Content-Type': 'application/json'
    }, body: body === undefined ? undefined : JSON.stringify(body)});
    assert(r.ok, `Local API ${method} ${url}: HTTP ${r.status}`);
    const value = await r.json();
    // Config GET/PUT return raw JSON; other admin routes use the data envelope.
    return Object.hasOwn(value, 'data') ? value.data : value;
  };
  const gate = await api('/api/v1/admin/compliance');
  const browser = await chromium.launch({ channel: 'chrome', headless: true });
  try {
    const page = await browser.newPage({ viewport: {width: 1440, height: 1100} });
    page.setDefaultTimeout(20000);
    await page.addInitScript(s => {
      localStorage.setItem('auth_token', s.access_token);
      localStorage.setItem('auth_user', JSON.stringify(s.user));
      localStorage.setItem('locale', 'zh');
    }, session);
    await page.goto(base + '/admin/plugins');
    if (gate.required) {
      await page.locator('#admin-compliance-phrase').waitFor();
      await page.screenshot({path: path.join(root, 'evidence', 'local-confirmation-status.png'), fullPage: true});
      fs.writeFileSync(path.join(root, 'evidence', 'local-confirmation-status.json'), JSON.stringify({
        checked_at: new Date().toISOString(), base, administrator: 'admin@statekit.local',
        required: true, version: gate.version, dialog_visible: true, acceptance_submitted: false
      }, null, 2) + '\n');
      console.log('ADMIN_ACK_PENDING required=true dialog_visible=true; browser did not accept any agreement');
      process.exitCode = 3; return;
    }
    const pluginKey = 'io.github.wangyunjeff.sub2api-state-kit';
    const plugin = (await api('/api/v1/admin/plugins')).find(p => p.plugin_key === pluginKey);
    assert(plugin, 'Install STATE Kit with start-local.py before browser verification');
    const prefix = '/api/v1/admin/plugins/' + plugin.id;
    const openControls = async () => {
      await page.locator('article').filter({hasText: pluginKey})
        .getByRole('button', { name: /配置|Configure/ }).click();
      const frame = page.frameLocator('iframe').first();
      await frame.locator('#config-fields:not([disabled])').waitFor();
      return frame;
    };
    let frame = await openControls();
    await frame.locator('#dynamic-proxy-url').waitFor();
    assert(await frame.locator('#new-account-group').count());
    assert(await frame.locator('#auto-harvest').count());
    assert(await frame.locator('#refresh-all').count());
    assert(await frame.locator('#manual-test').count());
    assert(await frame.locator('#activity-panel').count());
    const original = await api(prefix + '/config');
    const result = {controls_rendered: true, config_save_reload: false};
    // Only exercise mutations on the empty, disabled local fixture.
    if (!(original.accounts || []).length && !original.enabled && !original.auto_harvest) {
      assert(await frame.locator('#refresh-all').isDisabled());
      if (!await frame.locator('#manual-account').inputValue()) {
        let actionRequests = 0;
        const trackAction = request => {
          if (request.url() === base + prefix + '/actions') actionRequests++;
        };
        page.on('request', trackAction);
        try {
          await frame.locator('#manual-test').click();
          await frame.locator('#manual-result-title').filter({hasText: '请选择账号'}).waitFor();
          assert(actionRequests === 0, 'An empty-account model test must not dispatch actions');
          result.empty_account_browser_blocks = true;
        } finally { page.off('request', trackAction); }
      }
      const input = frame.locator('#attempt-interval-seconds');
      const initialInterval = await input.inputValue();
      const nextInterval = initialInterval === '11' ? '12' : '11';
      let submitted;
      try {
        const details = input.locator('xpath=ancestor::details');
        if (await details.count() && !await input.isVisible()) await details.locator('summary').click();
        await input.fill(nextInterval);
        const saved = page.waitForResponse(r => r.url() === base + prefix + '/config' && r.request().method() === 'PUT');
        await frame.locator('#save-config').click();
        const response = await saved;
        submitted = response.request().postDataJSON();
        assert(response.ok(), `Browser config save: HTTP ${response.status()}`);
        const stored = await api(prefix + '/config');
        assert(stored.attempt_interval_seconds === Number(nextInterval));
        assert(!stored.enabled && !stored.auto_harvest && !(stored.accounts || []).length);
        await page.reload();
        frame = await openControls();
        assert(await frame.locator('#attempt-interval-seconds').inputValue() === nextInterval);
        result.config_save_reload = true;
      } finally {
        if (submitted) {
          const current = await api(prefix + '/config');
          assert(isDeepStrictEqual(current, submitted) || isDeepStrictEqual(current, original),
            'Config changed concurrently; keep the newer configuration for review');
          await api(prefix + '/config', 'PUT', original);
          assert(isDeepStrictEqual(await api(prefix + '/config'), original), 'Exact configuration restoration failed');
          result.original_config_restored = true;
        }
      }
      await page.reload();
      frame = await openControls();
      assert(await frame.locator('#attempt-interval-seconds').inputValue() === initialInterval);
    } else {
      result.mutation_check_skipped = 'Existing user configuration preserved';
    }
    await page.screenshot({path: path.join(root, 'evidence', 'local-controls.png'), fullPage: true});
    fs.writeFileSync(path.join(root, 'evidence', 'local-browser.json'), JSON.stringify(result, null, 2) + '\n');
    console.log('LOCAL_BROWSER_CONTROLS_OK ' + JSON.stringify(result));
  } finally { await browser.close(); }
})().catch(e => { console.error(e.message); process.exitCode = 1; });
