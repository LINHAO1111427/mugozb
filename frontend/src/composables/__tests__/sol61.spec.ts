import { describe, expect, it, vi } from 'vitest'
vi.mock('@/api/admin/accounts', () => ({ getAntigravityDefaultModelMapping: vi.fn() }))
import { getModelsByPlatform, getPresetMappingsByPlatform } from '../useModelWhitelist'

describe('Sol model selection', () => {
  it('offers exact 6.1 and 6 identities without substituting one for the other', () => {
    for (const model of ['gpt-6.1-sol', 'gpt-6-sol']) {
      expect(getModelsByPlatform('openai')).toContain(model)
      expect(getPresetMappingsByPlatform('openai')).toEqual(expect.arrayContaining([
        expect.objectContaining({ from: model, to: model })
      ]))
    }
  })
})
