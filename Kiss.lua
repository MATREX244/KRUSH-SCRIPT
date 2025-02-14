-- Script para adicionar um menu preto e branco flutuante e móvel
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextButton1 = Instance.new("TextButton")
local TextButton2 = Instance.new("TextButton")
local TextButton3 = Instance.new("TextButton")
local TextButton4 = Instance.new("TextButton")

ScreenGui.Name = "Menu"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.Size = UDim2.new(0, 200, 0, 400)
Frame.Visible = true
Frame.Active = true -- Permite que o Frame seja arrastado
Frame.Draggable = true -- Torna o Frame móvel

TextButton1.Parent = Frame
TextButton1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton1.Position = UDim2.new(0.1, 0, 0.1, 0)
TextButton1.Size = UDim2.new(0, 150, 0, 50)
TextButton1.Text = "Ativar Ferramenta 1"

TextButton2.Parent = Frame
TextButton2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton2.Position = UDim2.new(0.1, 0, 0.3, 0)
TextButton2.Size = UDim2.new(0, 150, 0, 50)
TextButton2.Text = "Ativar Ferramenta 2"

TextButton3.Parent = Frame
TextButton3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton3.Position = UDim2.new(0.1, 0, 0.5, 0)
TextButton3.Size = UDim2.new(0, 150, 0, 50)
TextButton3.Text = "Mira Automática"

TextButton4.Parent = Frame
TextButton4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton4.Position = UDim2.new(0.1, 0, 0.7, 0)
TextButton4.Size = UDim2.new(0, 150, 0, 50)
TextButton4.Text = "Imortalidade"

-- Função para desenhar linha e círculo no adversário
function desenharAlvo(player)
    local linha = Drawing.new("Line")
    local circulo = Drawing.new("Circle")

    linha.Visible = true
    linha.Color = Color3.fromRGB(255, 0, 0)
    linha.Thickness = 2

    circulo.Visible = true
    circulo.Color = Color3.fromRGB(255, 0, 0)
    circulo.Thickness = 2
    circulo.Filled = false

    -- Atualiza posição do alvo
    game:GetService("RunService").RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local alvoPos = player.Character.HumanoidRootPart.Position
            linha.From = game.Players.LocalPlayer.Character.Head.Position
            linha.To = alvoPos

            circulo.Position = alvoPos
            circulo.Radius = 5
        end
    end)
end

-- Função para encontrar o player mais próximo
function encontrarPlayerMaisProximo()
    local players = game.Players:GetPlayers()
    local localPlayer = game.Players.LocalPlayer
    local maisProximo = nil
    local menorDistancia = math.huge

    for _, player in pairs(players) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distancia = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if distancia < menorDistancia então
                menorDistancia = distancia
                maisProximo = player
            end
        end
    end

    return maisProximo
end

-- Função para ativar a ferramenta de mira automática
function miraAutomatica()
    local adversario = encontrarPlayerMaisProximo()
    if adversario então
        game:GetService("RunService").RenderStepped:Connect(function()
            if adversario.Character e adversario.Character:FindFirstChild("Head") então
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, adversario.Character.Head.Position)
            end
        end)
    end
end

-- Função para ativar a mira na cabeça em todas as circunstâncias
function miraCabecaIndependente()
    local adversario = encontrarPlayerMaisProximo()
    if adversario então
        game:GetService("RunService").RenderStepped:Connect(function()
            if adversario.Character e adversario.Character:FindFirstChild("Head") então
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, adversario.Character.Head.Position)
                -- Ajuste a velocidade de mira conforme necessário
                localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(localPlayer.Character.HumanoidRootPart.Position, Vector3.new(adversario.Character.Head.Position.X, adversario.Character.Head.Position.Y, adversario.Character.Head.Position.Z))
            end
        end)
    end
end

-- Função para ativar a imortalidade
function ativarImortalidade()
    local player = game.Players.LocalPlayer
    if player e player.Character e player.Character:FindFirstChild("Humanoid") então
        player.Character.Humanoid.MaxHealth = math.huge
        player.Character.Humanoid.Health = math.huge
        player.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if player.Character.Humanoid.Health < math.huge então
                player.Character.Humanoid.Health = math.huge
            end
        end)
    end
end

TextButton1.MouseButton1Click:Connect(function()
    local adversario = encontrarPlayerMaisProximo()
    if adversario então
        desenharAlvo(adversario)
    end
end)

TextButton2.MouseButton1Click:Connect(function()
    miraAutomatica()
end)

TextButton3.MouseButton1Click:Connect(function()
    miraCabecaIndependente()
end)

TextButton4.MouseButton1Click:Connect(function()
    ativarImortalidade()
end)
