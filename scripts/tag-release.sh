#!/usr/bin/env bash
set -euo pipefail
REPO_URL="https://github.com/De-ASI-INTERFACE/x402-starknet-extension"
TAG="v1.0.0" && MESSAGE="x402-Starknet Extension v1.0.0 — Richard Patterson"
if [ ! -f "lakefile.lean" ]; then echo "ERROR: Run from repo root."; exit 1; fi
git fetch origin && COMMIT=$(git rev-parse HEAD)
git tag -a "$TAG" "$COMMIT" -m "$MESSAGE" && git push origin "$TAG"
echo "Publish at: $REPO_URL/releases/new?tag=$TAG"
