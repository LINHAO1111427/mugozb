package openai

import (
	"github.com/stretchr/testify/require"
	"testing"
)

func TestSol61ModelCatalog(t *testing.T) {
	require.Contains(t, DefaultModelIDs(), "gpt-6.1-sol")
	require.Contains(t, DefaultModelIDs(), "gpt-6-sol")
	seen := map[string]bool{}
	for _, model := range DefaultModels {
		require.False(t, seen[model.ID], "duplicate model %s", model.ID)
		seen[model.ID] = true
	}
}
