#!/bin/bash

TARGET='ELFKit'
REPO_NAME='ELFKit'

generate_docc() {
  mkdir -p docs

  $(xcrun --find docc) convert \
    "./Sources/${TARGET}/Documentation.docc" \
     --output-path "docs" \
     --hosting-base-path "${REPO_NAME}" \
     --additional-symbol-graph-dir ./symbol-graphs
}

sh ./scripts/generate-symbols.sh

generate_docc
