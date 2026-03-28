cask "vectordbz" do
  version "0.0.18"
  sha256 "c98a3c19bda3f1a3b584e6af580a62e9dc485f3a2deb702e3f50676ad4e51b62"

  url "https://github.com/vectordbz/vectordbz/releases/download/v#{version}/VectorDBZ-darwin-arm64-#{version}.zip"
  name "VectorDBZ"
  desc "Vector database GUI client supporting Qdrant, Weaviate, Milvus, ChromaDB, Pinecone, pgvector, Elasticsearch, and RedisSearch"
  homepage "https://github.com/vectordbz/vectordbz"

  depends_on macos: ">= :ventura"
  arch hardware: :arm64

  app "VectorDBZ.app"

  zap trash: [
    "~/Library/Application Support/VectorDBZ",
    "~/Library/Preferences/com.vectordbz.app.plist",
    "~/Library/Logs/VectorDBZ",
    "~/Library/Caches/VectorDBZ",
  ]
end
