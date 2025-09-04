# Notbooks DevOps

Estes são as minhas anotações, dos meus estudos de devOps via Jupyter Notebooks

# Getting Start

Primeiro crie os diretórios necessários para os Notebooks

```shell
mkdir -p ~/jupyter-workspace/{notebooks,scripts,data}
cd ~/jupyter-workspace
```

Após, Execute o docker compose **(Recomendado)** para subir os containers

```shell
docker compose up -d
```

Ou se preferir sem docker compose

```shell
docker run -p 8888:8888 \
  -v "$(pwd)/notebooks:/home/jovyan/work/notebooks" \
  -v "$(pwd)/scripts:/home/jovyan/work/scripts" \
  -v "$(pwd)/data:/home/jovyan/work/data" \
  --name my-jupyter-lab \
  jupyter/datascience-notebook:latest
```

> É necessária a configuração do plugin magma se estiver utilizando o neovim. Caso deseje, pode utilizar dos meus dotfiles o **TurasVim**

Configuração do magma abaixo

```lua
return {
  {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins", -- ESSENCIAL: Executa esse comando após instalar/atualizar
    init = function()
      -- Configurações Básicas (ativas antes do plugin carregar)
      vim.g.magma_automatically_open_output = true
      vim.g.magma_image_provider = "kitty" -- Escolha 'ueberzug', 'kitty', 'wezterm' ou 'none'
      vim.g.magma_wrap_output = true
      vim.g.magma_output_window_borders = false
      vim.g.magma_save_path = vim.fn.expand("~/.jupyter/magma-nvim") -- Onde salvar os notebooks

      -- Configuração AVANÇADA: Se você estiver usando um container Docker,
      -- descomente e ajuste a linha abaixo com o token do seu Jupyter Lab
      -- vim.g.magma_jupyter_connection_string = "http://127.0.0.1:8888/?token=seu_token_aqui"
    end,
    config = function()
      -- Configurações que rodam após o plugin ser carregado
      -- Mapeamentos de teclas (Mantenha isso fora do init())
      local map = vim.keymap.set
      map("n", "<leader>ji", "<cmd>MagmaInit<cr>", { desc = "Magma: Init", silent = true })
      map("n", "<leader>je", "<cmd>MagmaEvaluateLine<cr>", { desc = "Magma: Eval Line", silent = true })
      map("v", "<leader>je", "<cmd>MagmaEvaluateVisual<cr>", { desc = "Magma: Eval Visual", silent = true })
      map("n", "<leader>jr", "<cmd>MagmaReevaluateCell<cr>", { desc = "Magma: Reeval Cell", silent = true })
      map("n", "<leader>jd", "<cmd>MagmaDelete<cr>", { desc = "Magma: Delete", silent = true })
      map("n", "<leader>jo", "<cmd>MagmaShowOutput<cr>", { desc = "Magma: Show Output", silent = true })
      map("n", "<leader>jc", "o# %%<Esc>", { desc = "Jupyter: New Cell Markdown" })
    end,
  },
}
```

# Definir o token do jupyter

Execute o seguinte comando

```shell
# Suba o container (sem definir JUPYTER_TOKEN no compose)
docker compose up -d

# Comando para extrair o token dos logs de forma limpa
docker compose logs jupyter-lab | grep -o "token=[a-zA-Z0-9]*" | head -n1 | cut -d= -f2

# Ou, de forma ainda mais direta, execute isso dentro do container:
docker exec my-jupyter-lab jupyter server list | grep -o "token=[a-zA-Z0-9]*" | head -n1 | cut -d= -f2
```
