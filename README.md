# homebrew-vectordbz

Homebrew tap for [VectorDBZ](https://github.com/vectordbz/vectordbz) — a GUI client for vector databases.

Supports: Qdrant, Weaviate, Milvus, ChromaDB, Pinecone, pgvector (PostgreSQL), Elasticsearch, and RedisSearch.

## Install

```sh
brew tap vectordbz/vectordbz
brew install --cask vectordbz
```

## Requirements

- macOS Ventura (13) or later
- Apple Silicon (M1/M2/M3) — ARM64 only

## Update

```sh
brew upgrade --cask vectordbz
```

## Uninstall

```sh
brew uninstall --cask vectordbz
```

## Maintaining — bump the version

When a new VectorDBZ release is published, run the update script from the root of this repo:

```sh
bash scripts/update-cask.sh
git push origin master
```

The script will:
1. Fetch the latest release from the GitHub API
2. Parse the new version number and SHA256 hash automatically
3. Update `Casks/vectordbz.rb`
4. Create a git commit

No manual copy-pasting needed.
