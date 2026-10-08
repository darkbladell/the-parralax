-- ============================================
-- THE PALARRAX - LOADER
-- ============================================

local URL = "https://raw.githubusercontent.com/darkbladell/the-parralax/main/prison-life.lua"

print("[PLX] Carregando: " .. URL)

local sucesso, resultado = pcall(function()
    return game:HttpGet(URL, true)
end)

if sucesso and resultado and #resultado > 100 then
    local ok, err = pcall(function()
        loadstring(resultado)()
    end)
    if ok then
        print("[PLX] ✅ prison-life carregado")
    else
        warn("[PLX] ❌ Erro: " .. tostring(err))
    end
else
    warn("[PLX] ❌ Falha ao baixar o script")
end
