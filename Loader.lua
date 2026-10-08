-- ============================================
-- THE PALARRAX - LOADER
-- ============================================

local BASE = "https://raw.githubusercontent.com/darkbladell/the-parralax/main/"

local function loadScript(nome)
    local url = BASE .. nome
    print("[PLX] Carregando: " .. url)
    local sucesso, resultado = pcall(function()
        return game:HttpGet(url, true)
    end)
    if sucesso and resultado and #resultado > 100 then
        local ok, err = pcall(function()
            loadstring(resultado)()
        end)
        if ok then
            print("[PLX] ✅ " .. nome .. " carregado")
            return true
        else
            warn("[PLX] ❌ Erro em " .. nome .. ": " .. tostring(err))
        end
    else
        warn("[PLX] ❌ Falha ao baixar " .. nome)
    end
    return false
end

loadScript("palarrax.lua")
task.wait(0.5)
loadScript("palarrax2.lua")

print("✅ THE PALARRAX carregado!")
