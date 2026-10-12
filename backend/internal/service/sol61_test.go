package service

import (
	"github.com/Wei-Shaw/sub2api/internal/config"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestSol61RoutingPreservesModelIdentity(t *testing.T) {
	for _, model := range []string{"gpt-6.1-sol", "gpt-6-sol"} {
		for _, input := range []string{model, "openai/" + model, model + "-high", model + "-max"} {
			require.Equal(t, model, normalizeCodexModel(input), input)
		}
	}
	for _, input := range []string{"gpt-6.1-sol-custom", "gpt-6.1-sol-excel", "gpt-6.1-other"} {
		require.Equal(t, input, normalizeCodexModel(input))
	}
	require.Equal(t, "gpt-6-astra", normalizeCodexModel("gpt-6"))
}

func TestSol61ManifestReasoning(t *testing.T) {
	require.True(t, isOpenAICodexReasoningGPTModel("gpt-6.1-sol"))
	require.True(t, isOpenAICodexImageInputModel("gpt-6.1-sol"))
	require.True(t, configuredCodexSupportsPriorityServiceTier("gpt-6.1-sol"))
	descriptor := newConfiguredCodexModelDescriptor("gpt-6.1-sol")
	require.EqualValues(t, 1_050_000, descriptor.ContextWindow)
	require.EqualValues(t, 1_050_000, descriptor.MaxContextWindow)
	_, usesFullResponses := apiKeyCodexModelsWithoutResponsesLite["gpt-6.1-sol"]
	require.True(t, usesFullResponses)
	var efforts []string
	for _, level := range configuredCodexGPTReasoningLevels("gpt-6.1-sol") {
		efforts = append(efforts, level.Effort)
	}
	require.Equal(t, []string{"low", "medium", "high", "xhigh", "max"}, efforts)
}

func TestSol61PricingAcrossTiersAndLongContext(t *testing.T) {
	for _, remote := range []bool{false, true} {
		var pricing *PricingService
		if remote {
			// Stale catalogs must not make Sol inherit Astra or legacy fallback prices.
			pricing = &PricingService{pricingData: map[string]*LiteLLMModelPricing{
				"gpt-6":   {InputCostPerToken: 10e-6, OutputCostPerToken: 50e-6},
				"gpt-5.4": {InputCostPerToken: 2.5e-6, OutputCostPerToken: 15e-6},
			}}
		}
		svc := NewBillingService(&config.Config{}, pricing)
		for _, model := range []string{"gpt-6.1-sol", "openai/gpt-6.1-sol", "gpt-6.1-sol-excel"} {
			for _, tier := range []struct {
				name  string
				scale float64
			}{{"", 1}, {"priority", 2}, {"flex", 0.5}} {
				for _, input := range []int{272000, 272001} {
					tokens := UsageTokens{InputTokens: input - 2000, CacheReadTokens: 1000, CacheCreationTokens: 1000, OutputTokens: 100}
					cost, err := svc.CalculateCostWithServiceTier(model, tokens, 1, tier.name)
					require.NoError(t, err, "%s remote=%v", model, remote)
					inScale, outScale := tier.scale, tier.scale
					if input > 272000 {
						inScale *= 2
						outScale *= 1.5
					}
					require.Equal(t, input > 272000, cost.LongContextBillingApplied)
					require.InDelta(t, float64(input-2000)*2e-6*inScale, cost.InputCost, 1e-10)
					require.InDelta(t, 1000*0.1e-6*inScale, cost.CacheReadCost, 1e-10)
					require.InDelta(t, 1000*2.5e-6*inScale, cost.CacheCreationCost, 1e-10)
					require.InDelta(t, 100*10e-6*outScale, cost.OutputCost, 1e-10)
				}
			}
		}
	}
}
