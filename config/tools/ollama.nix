{ ... }:

{
  services.ollama = {
    enable = true;
    loadModels = [ "mistral:7b" "deepseek-r1:14b" "qwen2.5:14b" ];
  };
}
