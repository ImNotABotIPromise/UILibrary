local App = {}

local UserInputService = game:GetService("UserInputService")

local Player = game:GetService("Players").LocalPlayer

local CodeStyle = 1

function dragify(obj)
	local UserInputService = game:GetService("UserInputService")
	local function dragify(Frame)
		local dragToggle = nil
		local dragInput = nil
		local dragStart = nil
		local dragPos = nil
		local startPos
		local function updateInput(input)
			local Delta = input.Position - dragStart
			local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.05), {Position = Position}):Play()
		end
		Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UserInputService:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		Frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragToggle then
				updateInput(input)
			end
		end)
	end

	dragify(obj)
end

function createGui(settings)
	if settings.CodeStyle then
		if settings.CodeStyle == 1 then
			CodeStyle = settings.CodeStyle
		elseif settings.CodeStyle == 2 then
			CodeStyle = settings.CodeStyle
		end
	end

	local Gui = Instance.new("ScreenGui", game.CoreGui)
	Gui.Name = settings.Name or "Gui"
	Gui.ResetOnSpawn = false

	local Drag = Instance.new("Frame", Gui)
	Drag.Name = "Drag"
	Drag.Size = UDim2.new(0, 500, 0, 45)
	Drag.BackgroundTransparency = 1
	Drag.Position = UDim2.new(.5, 0, .5, -176)
	Drag.AnchorPoint = Vector2.new(.5, .5)

	local Main = Instance.new("Frame", Drag)
	Main.Name = "Main"
	Main.Size = UDim2.new(0, 500, 0, 400)
	Main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Main.BorderSizePixel = 0

	local Main_UICorner = Instance.new("UICorner", Main)
	Main_UICorner.Name = "Main_UICorner"
	Main_UICorner.CornerRadius = UDim.new(0, 3)

	local Main_UIListLayout = Instance.new("UIListLayout", Main)
	Main_UIListLayout.Name = "Main_UIListLayout"
	Main_UIListLayout.Padding = UDim.new(0, 6)
	Main_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Main_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local Topbar = Instance.new("Frame", Main)
	Topbar.Name = "Topbar"
	Topbar.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	Topbar.BorderSizePixel = 0
	Topbar.Size = UDim2.new(1, 0, 0, 45)

	local Topbar_TextLabel = Instance.new("TextLabel", Topbar)
	Topbar_TextLabel.Name = "Topbar_TextLabel"
	Topbar_TextLabel.Text = settings.Title or "UILibrary"
	Topbar_TextLabel.BackgroundTransparency = 1
	Topbar_TextLabel.Font = Enum.Font.GothamBold
	Topbar_TextLabel.TextSize = 15
	Topbar_TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	Topbar_TextLabel.Size = UDim2.new(1, -17, 1, 0)
	Topbar_TextLabel.Position = UDim2.new(0, 17, 0, 0)
	Topbar_TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	local Topbar_UICorner = Instance.new("UICorner", Topbar)
	Topbar_UICorner.Name = "Topbar_UICorner"
	Topbar_UICorner.CornerRadius = UDim.new(0, 3)

	local Middlebar = Instance.new("Frame", Main)
	Middlebar.Name = "Middlebar"
	Middlebar.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	Middlebar.BorderSizePixel = 0
	Middlebar.Size = UDim2.new(1, -10, 0, 40)

	local Middlebar_UICorner = Instance.new("UICorner", Middlebar)
	Middlebar_UICorner.Name = "Middlebar_UICorner"
	Middlebar_UICorner.CornerRadius = UDim.new(0, 3)

	local Middlebar_Holder = Instance.new("ScrollingFrame", Middlebar)
	Middlebar_Holder.Name = "Middlebar_Holder"
	Middlebar_Holder.Size = UDim2.new(1, -40, 1, 0)
	Middlebar_Holder.BackgroundTransparency = 1
	Middlebar_Holder.Position = UDim2.new(0, 20, 0, 0)
	Middlebar_Holder.ScrollBarThickness = 2
	Middlebar_Holder.ScrollBarImageTransparency = 1
	Middlebar_Holder.CanvasSize = UDim2.new(0, 0, 0, 0)
	Middlebar_Holder.ClipsDescendants = true

	Middlebar_Holder.ChildAdded:Connect(function()
		local Size = 0

		for _,Tab in pairs(Middlebar_Holder:GetChildren()) do
			if Tab:IsA("TextButton") then
				wait(.025)
				Size = Size + Tab.Size.X.Offset + 20 
			end
		end

		Middlebar_Holder.CanvasSize = UDim2.new(0, Size - 20, 0, 0)
	end)

	local Middlebar_Holder_UIListLayout = Instance.new("UIListLayout", Middlebar_Holder)
	Middlebar_Holder_UIListLayout.Name = "Middlebar_Holder_UIListLayout"
	Middlebar_Holder_UIListLayout.Padding = UDim.new(0, 20)
	Middlebar_Holder_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	Middlebar_Holder_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	Middlebar_Holder_UIListLayout.FillDirection = Enum.FillDirection.Horizontal

	local Pages = Instance.new("Frame", Main)
	Pages.Name = "Pages"
	Pages.BackgroundTransparency = 1
	Pages.Size = UDim2.new(1, -10, 1, -103)
	Pages.ClipsDescendants = false

	local Items = {}
	local function ListItems(Obj)
		Items[Obj.Name] = Obj

		for _,Item in pairs(Obj:GetChildren()) do
			ListItems(Item)
		end
	end
	ListItems(Gui)

	return Gui, Items
end

function App.Load(settings)
	local Functions = {}

	local Gui, Items = createGui(settings)

	local PageDebounce = false

	function Functions.New(settings)
		if Items.Pages:FindFirstChild(settings.Title or "Page") then return end

		local Functions = {}

		local TextButton = Instance.new("TextButton", Items.Middlebar_Holder)
		TextButton.Name = settings.Title or "Page"
		TextButton.Text = string.upper(settings.Title) or "PAGE"
		TextButton.BackgroundTransparency = 1
		TextButton.Font = Enum.Font.GothamBold
		TextButton.TextSize = 14
		TextButton.Size = UDim2.new(0, TextButton.TextBounds.X, 1, 0)

		local Page = Instance.new("ScrollingFrame", Items.Pages)
		Page.Name = settings.Title or "Page"
		Page.Size = UDim2.new(1.32, 0, 1, 0)
		Page.BackgroundTransparency = 1
		Page.ScrollBarImageTransparency = 1
		Page.ScrollBarThickness = 0
		Page.BorderSizePixel = 0
		Page.ClipsDescendants = true

		local Page_UIListLayout = Instance.new("UIListLayout", Page)
		Page_UIListLayout.Name = "Page_UIListLayout"
		Page_UIListLayout.Padding = UDim.new(0, 6)
		Page_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

		if settings.Active == true then
			TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			Page.Size = UDim2.new(1.32, 0, 1, 0)
		else
			TextButton.TextColor3 = Color3.fromRGB(80, 80, 80)
			Page.Size = UDim2.new(0, 0, 1, 0)
		end

		Page.ChildAdded:Connect(function(obj)
			local Size = 0

			for _,obj in pairs(Page:GetChildren()) do
				if obj:IsA("Frame") then
					wait(.05)
					Size = Size + (obj.Size.Y.Offset + 6)
				end
			end

			Page.CanvasSize = UDim2.new(0, 0, 0, Size - 6)
		end)

		Page.ChildRemoved:Connect(function(obj)
			local Size = 0

			for _,obj in pairs(Page:GetChildren()) do
				if obj:IsA("Frame") then
					wait(.05)
					Size = Size + (obj.Size.Y.Offset + 6)
				end
			end

			Page.CanvasSize = UDim2.new(0, 0, 0, Size - 6)
		end)

		TextButton.MouseButton1Click:Connect(function()
			if PageDebounce == true then return end
			PageDebounce = true

			local Tween = nil

			for _,p in pairs(Items.Middlebar_Holder:GetChildren()) do
				if p:IsA("TextButton") then
					if p.Name == TextButton.Name then
						Tween = game.TweenService:Create(p, TweenInfo.new(.3), {
							TextColor3 = Color3.fromRGB(255, 255, 255)
						})
					else
						game.TweenService:Create(p, TweenInfo.new(.3), {
							TextColor3 = Color3.fromRGB(80, 80, 80)
						}):Play()
					end
				end
			end

			local Tween1 = nil

			for _,p2 in pairs(Items.Pages:GetChildren()) do
				if p2:IsA("ScrollingFrame") then
					if p2.Name == TextButton.Name then
						Tween1 = game.TweenService:Create(p2, TweenInfo.new(.3), {
							Size = UDim2.new(1.32, 0, 1, 0)
						})
					else
						if math.floor(p2.Size.X.Scale) == 1 then
							game.TweenService:Create(p2, TweenInfo.new(.3), {
								Size = UDim2.new(0, 0, 1, 0)
							}):Play()

							wait(.3)

							print(p2.Size)
						end
					end
				end
			end

			Tween:Play()
			Tween1:Play()

			wait(.3)

			PageDebounce = false
		end)

		function Functions.Label(title)
			local Functions = {}

			local Frame = Instance.new("Frame", Page)
			Frame.Name = title or "Label"
			Frame.Size = UDim2.new(0, 490, 0, 40)
			Frame.BorderSizePixel = 0
			Frame.BackgroundColor3 = Color3.fromRGB(55, 55, 55)

			local Frame_UICorner = Instance.new("UICorner", Frame)
			Frame_UICorner.Name = "Frame_UICorner"
			Frame_UICorner.CornerRadius = UDim.new(0, 3)

			local Label = Instance.new("TextLabel", Frame)
			Label.Name = "Label"
			Label.Text = title or "Label"
			Label.BackgroundTransparency = 1
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Font = Enum.Font.GothamSemibold
			Label.TextSize = 14
			Label.Size = UDim2.new(1, -12, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)

			function Functions:GetText()
				return Label.Text
			end

			function Functions:SetText(text)
				if text then
					if typeof(text) == "string" or typeof(text) == "number" then
						Label.Text = text
					end
				end
			end

			return Functions
		end

		function Functions.Button(settings, callback)
			local Frame = Instance.new("Frame", Page)
			Frame.Name = settings.Title or "Button"
			Frame.Size = UDim2.new(0, 490, 0, 40)
			Frame.BorderSizePixel = 0
			Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

			local Frame_UICorner = Instance.new("UICorner", Frame)
			Frame_UICorner.Name = "Frame_UICorner"
			Frame_UICorner.CornerRadius = UDim.new(0, 3)

			local Button = Instance.new("TextButton", Frame)
			Button.Name = "Button"
			Button.Text = settings.Title or "Button"
			Button.BackgroundTransparency = 1
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.TextXAlignment = Enum.TextXAlignment.Left
			Button.Font = Enum.Font.GothamSemibold
			Button.TextSize = 14
			Button.Size = UDim2.new(1, -12, 1, 0)
			Button.Position = UDim2.new(0, 12, 0, 0)

			local Returned = {}

			function Returned:GetText(text)
				return Button.Text
			end

			function Returned:SetText(text)
				if text then
					if typeof(text) == "string" or typeof(text) == "number" then
						Button.Text = text
					end
				end
			end

			Returned.Object = Frame

			Button.MouseButton1Click:Connect(function()
				if CodeStyle == 1 then
					if settings.Callback then settings.Callback(Returned) end
				elseif CodeStyle == 2 then
					if callback then callback(Returned) end
				end
			end)

			return Returned
		end

		function Functions.Input(settings, callback)
			local Frame = Instance.new("Frame", Page)
			Frame.Name = settings.Title or "Button"
			Frame.Size = UDim2.new(0, 490, 0, 40)
			Frame.BorderSizePixel = 0
			Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

			local Frame_UICorner = Instance.new("UICorner", Frame)
			Frame_UICorner.Name = "Frame_UICorner"
			Frame_UICorner.CornerRadius = UDim.new(0, 3)

			local TextBox = Instance.new("TextBox", Frame)
			TextBox.Name = "TextBox"
			TextBox.PlaceholderText = settings.Title or "TextBox"
			TextBox.BackgroundTransparency = 1
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextXAlignment = Enum.TextXAlignment.Left
			TextBox.Font = Enum.Font.GothamSemibold
			TextBox.TextSize = 14
			TextBox.Size = UDim2.new(1, -24, 1, 0)
			TextBox.Position = UDim2.new(0, 12, 0, 0)
			TextBox.Text = ""
			TextBox.TextTruncate = Enum.TextTruncate.AtEnd

			local Returned = {}

			function Returned:GetText()
				return TextBox.Text 
			end

			function Returned:SetText(text)
				if text then
					if typeof(text) == "string" or typeof(text) == "number" then
						TextBox.Text = text
					end
				end
			end

			Returned.Object = Frame

			TextBox.Changed:Connect(function()
				if CodeStyle == 1 then
					if settings.Callback then settings.Callback(TextBox.Text, Returned) end
				elseif CodeStyle == 2 then
					if callback then callback(TextBox.Text, Returned) end
				end
			end)

			return Returned
		end

		function Functions.Toggle(settings, callback)
			local Toggled = false
			local Debounce = false

			local Frame = Instance.new("Frame", Page)
			Frame.Name = settings.Title or "Toggle"
			Frame.Size = UDim2.new(0, 490, 0, 40)
			Frame.BorderSizePixel = 0
			Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

			local Frame_UICorner = Instance.new("UICorner", Frame)
			Frame_UICorner.Name = "Frame_UICorner"
			Frame_UICorner.CornerRadius = UDim.new(0, 3)

			local TextLabel = Instance.new("TextLabel", Frame)
			TextLabel.Name = "TextLabel"
			TextLabel.Text = settings.Title or "Toggle"
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Font = Enum.Font.GothamSemibold
			TextLabel.TextSize = 14
			TextLabel.Size = UDim2.new(1, -24, 1, 0)
			TextLabel.Position = UDim2.new(0, 12, 0, 0)

			local Toggle_Holder = Instance.new("Frame", Frame)
			Toggle_Holder.Name = "Toggle_Holder"
			Toggle_Holder.BackgroundTransparency = 1
			Toggle_Holder.Size = UDim2.new(0, 55, 1, 0)
			Toggle_Holder.Position = UDim2.new(1, 0, 0, 0)
			Toggle_Holder.AnchorPoint = Vector2.new(1, 0)

			local Toggle = Instance.new("Frame", Toggle_Holder)
			Toggle.Name = "Toggle"
			Toggle.Size = UDim2.new(0, 35, 0, 15)
			Toggle.Position = UDim2.new(.5, 0, .5, 0)
			Toggle.AnchorPoint = Vector2.new(.5, .5)
			Toggle.BorderSizePixel = 0
			Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

			local Toggle_UICorner = Instance.new("UICorner", Toggle)
			Toggle_UICorner.Name = "Toggle_UICorner"
			Toggle_UICorner.CornerRadius = UDim.new(1, 0)

			local Toggle_Button = Instance.new("Frame", Toggle)
			Toggle_Button.Name = "Toggle_Button"
			Toggle_Button.BorderSizePixel = 0
			Toggle_Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			Toggle_Button.Size = UDim2.new(0, 20, 0, 20)
			Toggle_Button.AnchorPoint = Vector2.new(0, .5)
			Toggle_Button.Position = UDim2.new(0, 0, .5, 0)

			local Toggle_Button_UICorner = Instance.new("UICorner", Toggle_Button)
			Toggle_Button_UICorner.Name = "Toggle_Button_UICorner"
			Toggle_Button_UICorner.CornerRadius = UDim.new(1, 0)

			local Button = Instance.new("TextButton", Frame)
			Button.Name = "Button"
			Button.TextTransparency = 1
			Button.BackgroundTransparency = 1
			Button.Size = UDim2.new(1, 0, 1, 0)
			Button.ZIndex = 5

			if settings.Toggled then
				if settings.Toggled == true then
					Toggle_Button.Position = UDim2.new(0, 15, .5, 0)
					Toggled = true
				else
					Toggle_Button.Position = UDim2.new(0, 0, .5, 0)
					Toggled = false
				end
			end

			local Returned = {}

			function Returned:GetValue()
				return Toggled
			end

			function Returned:SetValue(value)
				if value == true then
					Debounce = true

					game.TweenService:Create(Toggle_Button, TweenInfo.new(.2), {
						Position = UDim2.new(0, 15, .5, 0)
					}):Play()

					wait(.2)

					Toggled = true
					Debounce = false
				elseif value == false then
					Debounce = true

					game.TweenService:Create(Toggle_Button, TweenInfo.new(.2), {
						Position = UDim2.new(0, 0, .5, 0)
					}):Play()

					wait(.2)

					Toggled = false
					Debounce = false
				end
			end

			function Returned:SetText(text)
				if text then
					if typeof(text) == "string" or typeof(text) == "number" then
						TextLabel.Text = text
					end
				end
			end

			function Returned:GetText(text)
				return TextLabel.Text
			end

			Returned.Object = Frame

			Button.MouseButton1Click:Connect(function()
				if Toggled == true then 
					if CodeStyle == 1 then
						if settings.Callback then settings.Callback(false, Returned) end
					elseif CodeStyle == 2 then
						if callback then callback(false, Returned) end
					end
				elseif Toggled == false then
					if CodeStyle == 1 then
						if settings.Callback then settings.Callback(true, Returned) end
					elseif CodeStyle == 2 then
						if callback then callback(true, Returned) end
					end
				end

				if Debounce then return end
				Debounce = true

				if Toggled == true then
					game.TweenService:Create(Toggle_Button, TweenInfo.new(.2), {
						Position = UDim2.new(0, 0, .5, 0)
					}):Play()

					wait(.2)

					Toggled = false
					Debounce = false
				elseif Toggled == false then
					game.TweenService:Create(Toggle_Button, TweenInfo.new(.2), {
						Position = UDim2.new(0, 15, .5, 0)
					}):Play()

					wait(.2)

					Toggled = true
					Debounce = false
				end
			end)

			return Returned
		end

		function Functions.Slider(settings, callback)
			local Down = false

			local MinValue = settings.Min or 0
			local MaxValue = settings.Max or 100

			local Mouse = Player:GetMouse()

			local Value

			local Frame = Instance.new("Frame", Page)
			Frame.Name = settings.Title or "Slider"
			Frame.Size = UDim2.new(0, 490, 0, 50)
			Frame.BorderSizePixel = 0
			Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

			local Frame_UICorner = Instance.new("UICorner", Frame)
			Frame_UICorner.Name = "Frame_UICorner"
			Frame_UICorner.CornerRadius = UDim.new(0, 3)

			local TextLabel = Instance.new("TextLabel", Frame)
			TextLabel.Name = "TextLabel"
			TextLabel.Text = settings.Title or "Slider"
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Font = Enum.Font.GothamSemibold
			TextLabel.TextSize = 14
			TextLabel.Size = UDim2.new(.5, 0, 0, 40)
			TextLabel.Position = UDim2.new(0, 12, 0, 0)

			local ValueLabel = Instance.new("TextLabel", Frame)
			ValueLabel.Name = "ValueLabel"
			ValueLabel.Text = MinValue
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
			ValueLabel.Font = Enum.Font.GothamBold
			ValueLabel.TextSize = 14
			ValueLabel.Size = UDim2.new(0, 100, 0, 40)
			ValueLabel.Position = UDim2.new(1, -10, 0, 0)
			ValueLabel.AnchorPoint = Vector2.new(1, 0)

			local Slider_Holder = Instance.new("Frame", Frame)
			Slider_Holder.Name = "Slider_Holder"
			Slider_Holder.BackgroundTransparency = 1
			Slider_Holder.Size = UDim2.new(1, 0, 0, 13)
			Slider_Holder.Position = UDim2.new(0, 0, 1, -2)
			Slider_Holder.AnchorPoint = Vector2.new(0, 1)

			local Slider = Instance.new("TextButton", Slider_Holder)
			Slider.Name = "Slider"
			Slider.Size = UDim2.new(1, -10, 0, 7)
			Slider.BorderSizePixel = 0
			Slider.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
			Slider.Position = UDim2.new(.5, 0, .5, 0)
			Slider.AnchorPoint = Vector2.new(.5, .5)
			Slider.TextTransparency = 1
			Slider.AutoButtonColor = false

			local Slider_UICorner = Instance.new("UICorner", Slider)
			Slider_UICorner.Name = "Slider_UICorner"
			Slider_UICorner.CornerRadius = UDim.new(0, 3)

			local Slider_Frame = Instance.new("Frame", Slider)
			Slider_Frame.Name = "Slider_Frame"
			Slider_Frame.Size = UDim2.new(0, 0, 1, 0)
			Slider_Frame.BorderSizePixel = 0
			Slider_Frame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			Slider_Frame.Position = UDim2.new(0, 0, 0, 0)

			local Slider_Frame_UICorner = Instance.new("UICorner", Slider_Frame)
			Slider_Frame_UICorner.Name = "Slider_Button_UICorner"
			Slider_Frame_UICorner.CornerRadius = UDim.new(0, 3)

			local Returned = {}

			function Returned:GetValue()
				return ValueLabel.Text
			end

			function Returned:SetValue(value)
				ValueLabel.Text = value
			end
			
			function Returned:SetText(text)
				if text then
					if typeof(text) == "string" or typeof(text) == "number" then
						TextLabel.Text = text
					end
				end
			end

			function Returned:GetText(text)
				return TextLabel.Text
			end

			Returned.Object = Frame

			Slider.MouseButton1Down:Connect(function()
				if not Gui then return end

				Down = true

				Value = math.floor((((tonumber(MaxValue) - tonumber(MinValue)) / 480) * Slider_Frame.AbsoluteSize.X) + tonumber(MinValue))

				ValueLabel.Text = Value

				Slider_Frame.Size = UDim2.new(0, math.clamp(Mouse.X - Slider.AbsolutePosition.X, 0, 480), 1, 0)
			end)

			Mouse.Move:Connect(function()
				if Down and Gui then
					ValueLabel.Text = Value

					Value = math.floor((((tonumber(MaxValue) - tonumber(MinValue)) / 480) * Slider_Frame.AbsoluteSize.X) + tonumber(MinValue))

					Slider_Frame.Size = UDim2.new(0, math.clamp(Mouse.X - Slider.AbsolutePosition.X, 0, 480), 1, 0)
				end
			end)

			UserInputService.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 and Gui and Down == true then
					Down = false

					Value = math.floor((((tonumber(MaxValue) - tonumber(MinValue)) / 480) * Slider_Frame.AbsoluteSize.X) + tonumber(MinValue))

					Slider_Frame.Size = UDim2.new(0, math.clamp(Mouse.X - Slider.AbsolutePosition.X, 0, 480), 1, 0)
				end
			end)

			ValueLabel.Changed:Connect(function(c)
				if c == "Text" and Gui then
					if CodeStyle == 1 then
						if settings.Callback then settings.Callback(ValueLabel.Text, Returned) end
					elseif CodeStyle == 2 then
						if callback then callback(ValueLabel.Text, Returned) end
					end
				end
			end)

			return Returned
		end

		function Functions.Color(settings, callback)
			local Frame = Instance.new("Frame", Page)
			Frame.Name = settings.Title or "Slider"
			Frame.Size = UDim2.new(0, 490, 0, 40)
			Frame.BorderSizePixel = 0
			Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

			local Frame_UICorner = Instance.new("UICorner", Frame)
			Frame_UICorner.Name = "Frame_UICorner"
			Frame_UICorner.CornerRadius = UDim.new(0, 3)

			local TextLabel = Instance.new("TextLabel", Frame)
			TextLabel.Name = "TextLabel"
			TextLabel.Text = settings.Title or "Slider"
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Font = Enum.Font.GothamSemibold
			TextLabel.TextSize = 14
			TextLabel.Size = UDim2.new(.5, 0, 0, 40)
			TextLabel.Position = UDim2.new(0, 12, 0, 0)

			local Display = Instance.new("TextButton", Frame)
			Display.Name = "Display"
			Display.Size = UDim2.new(0, 20, 1, -20)
			Display.Position = UDim2.new(1, -10, 0, 10)
			Display.AnchorPoint = Vector2.new(1, 0)
			Display.BorderSizePixel = 0
			Display.TextTransparency = 1
			Display.AutoButtonColor = false
			Display.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

			local Display_UICorner = Instance.new("UICorner", Display)
			Display_UICorner.Name = "Display_UICorner"
			Display_UICorner.CornerRadius = UDim.new(0, 3)

			local Frame2 = Instance.new("Frame", Frame)
			Frame2.Name = "Picker"
			Frame2.Size = UDim2.new(0, 140, 0, 100)
			Frame2.Position = UDim2.new(1, 10, .5, 0)
			Frame2.AnchorPoint = Vector2.new(0, .5)
			Frame2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			Frame2.BorderSizePixel = 0
			Frame2.Visible = false

			local ColorWheel = Instance.new("ImageButton", Frame2)
			ColorWheel.Name = "ColorWheel"
			ColorWheel.Size = UDim2.new(0, 90, 1, -10)
			ColorWheel.Position = UDim2.new(0, 5, 0, 5)
			ColorWheel.Image = "http://www.roblox.com/asset/?id=6020299385"
			ColorWheel.BackgroundTransparency = 1
			ColorWheel.ImageColor3 = Color3.fromRGB(255, 255, 255)

			local ColorWheel_Picker = Instance.new("ImageLabel", ColorWheel)
			ColorWheel_Picker.Name = "ColorWheel_Picker"
			ColorWheel_Picker.Image = "http://www.roblox.com/asset/?id=3678860011"
			ColorWheel_Picker.BackgroundTransparency = 1
			ColorWheel_Picker.Size = UDim2.new(.09, 0, .09, 0)
			ColorWheel_Picker.AnchorPoint = Vector2.new(.5, .5)
			ColorWheel_Picker.Position = UDim2.new(.5, 0, .5, 0)

			local DarknessPicker = Instance.new("TextButton", Frame2)
			DarknessPicker.Name = "DarknessPicker"
			DarknessPicker.TextTransparency = 1
			DarknessPicker.Size = UDim2.new(0, 30, 0, 90)
			DarknessPicker.Position = UDim2.new(1, -5, 0, 5)
			DarknessPicker.AnchorPoint = Vector2.new(1, 0)
			DarknessPicker.BorderSizePixel = 0
			DarknessPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DarknessPicker.AutoButtonColor = false

			local DarknessPicker_UICorner = Instance.new("UICorner", DarknessPicker)
			DarknessPicker_UICorner.Name = "DarknessPicker_UICorner"
			DarknessPicker_UICorner.CornerRadius = UDim.new(0, 3)

			local DarknessPicker_UIGradient = Instance.new("UIGradient", DarknessPicker)
			DarknessPicker_UIGradient.Name = "DarknessPicker_UIGradient"
			DarknessPicker_UIGradient.Rotation = 90
			DarknessPicker_UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
				ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
			})

			local DarknessPicker_Slider = Instance.new("Frame", DarknessPicker)
			DarknessPicker_Slider.Name = "Slider"
			DarknessPicker_Slider.Size = UDim2.new(1.2, 0, .027, 0)
			DarknessPicker_Slider.BorderSizePixel = 0
			DarknessPicker_Slider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			DarknessPicker_Slider.Position = UDim2.new(.5, 0, .073, 0)
			DarknessPicker_Slider.AnchorPoint = Vector2.new(.5, .5)

			local Button = Instance.new("TextButton", Frame)
			Button.Name = "Button"
			Button.TextTransparency = 1
			Button.BackgroundTransparency = 1
			Button.Size = UDim2.new(1, 0, 1, 0)
			Button.ZIndex = 5
			
			local Visible = false
			Button.MouseButton1Click:Connect(function()
				if Visible == true then
					Visible = false
				else
					Visible = true
				end

				Frame2.Visible = Visible
			end)

			local Frame2_UICorner = Instance.new("UICorner", Frame2)
			Frame2_UICorner.Name = "Frame2_UICorner"
			Frame2_UICorner.CornerRadius = UDim.new(0, 3)

			local UserInputService = game:GetService("UserInputService")

			local buttonDown = false
			local movingSlider = false

			local Returned = {}
            local HSV

			function Returned:TriggerCallback(data)
				if CodeStyle == 1 then
					if settings.Callback then settings.Callback(data, Returned) end
				elseif CodeStyle == 2 then
					if callback then callback(data, Returned) end
				end
			end

			function Returned:ChangeColor(color)
				Display.BackgroundColor3 = color
			end

			function Returned:GetColor()
				return HSV
			end

			Returned.Object = Frame

			local function updateColour(centreOfWheel)
				local colourPickerCentre = Vector2.new(
					ColorWheel_Picker.AbsolutePosition.X + (ColorWheel_Picker.AbsoluteSize.X/2),
					ColorWheel_Picker.AbsolutePosition.Y + (ColorWheel_Picker.AbsoluteSize.Y/2)
				)

				local h = (math.pi - math.atan2(colourPickerCentre.Y - centreOfWheel.Y, colourPickerCentre.X - centreOfWheel.X)) / (math.pi * 2)
				local s = (centreOfWheel - colourPickerCentre).Magnitude / (ColorWheel.AbsoluteSize.X/2)
				local v = math.abs((DarknessPicker_Slider.AbsolutePosition.Y - DarknessPicker.AbsolutePosition.Y) / DarknessPicker.AbsoluteSize.Y - 1)

				local hsv = Color3.fromHSV(math.clamp(h, 0, 1), math.clamp(s, 0, 1), math.clamp(v, 0, 1))
                HSV = Color3.fromHSV(math.clamp(h, 0, 1), math.clamp(s, 0, 1), math.clamp(v, 0, 1))

				if CodeStyle == 1 then
					if settings.Callback then settings.Callback(hsv, Returned) end
				elseif CodeStyle == 2 then
					if callback then callback(hsv, Returned) end
				end

				Display.BackgroundColor3 = hsv
				DarknessPicker.UIGradient.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, hsv), 
					ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
				}
			end

			ColorWheel.MouseButton1Down:Connect(function()
				buttonDown = true

				local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, game:GetService("GuiService"):GetGuiInset().Y)
				local centreOfWheel = Vector2.new(ColorWheel.AbsolutePosition.X + (ColorWheel.AbsoluteSize.X/2), ColorWheel.AbsolutePosition.Y + (ColorWheel.AbsoluteSize.Y/2))
				local distanceFromWheel = (mousePos - centreOfWheel).Magnitude

				if distanceFromWheel <= ColorWheel.AbsoluteSize.X/2 and buttonDown then
					ColorWheel_Picker.Position = UDim2.new(0, mousePos.X - ColorWheel.AbsolutePosition.X, 0, mousePos.Y - ColorWheel.AbsolutePosition.Y)

					updateColour(centreOfWheel)
				elseif movingSlider then
					DarknessPicker_Slider.Position = UDim2.new(.5, 0, 0, 
						math.clamp(
							mousePos.Y - DarknessPicker.AbsolutePosition.Y, 
							0, 
							DarknessPicker.AbsoluteSize.Y
						)
					)	

					updateColour(centreOfWheel)
				end
			end)

			DarknessPicker.MouseButton1Down:Connect(function()
				movingSlider = true

				local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, game:GetService("GuiService"):GetGuiInset().Y)
				local centreOfWheel = Vector2.new(ColorWheel.AbsolutePosition.X + (ColorWheel.AbsoluteSize.X/2), ColorWheel.AbsolutePosition.Y + (ColorWheel.AbsoluteSize.Y/2))
				local distanceFromWheel = (mousePos - centreOfWheel).Magnitude

				if distanceFromWheel <= ColorWheel.AbsoluteSize.X/2 and buttonDown then
					ColorWheel_Picker.Position = UDim2.new(0, mousePos.X - ColorWheel.AbsolutePosition.X, 0, mousePos.Y - ColorWheel.AbsolutePosition.Y)

					updateColour(centreOfWheel)
				elseif movingSlider then
					DarknessPicker_Slider.Position = UDim2.new(.5, 0, 0, 
						math.clamp(
							mousePos.Y - DarknessPicker.AbsolutePosition.Y, 
							0, 
							DarknessPicker.AbsoluteSize.Y
						)
					)	

					updateColour(centreOfWheel)
				end
			end)

			UserInputService.InputEnded:Connect(function(Input)
				if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

				buttonDown = false
				movingSlider = false
			end)

			UserInputService.InputChanged:Connect(function(Input)
				if Input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

				local mousePos = UserInputService:GetMouseLocation() - Vector2.new(0, game:GetService("GuiService"):GetGuiInset().Y)
				local centreOfWheel = Vector2.new(ColorWheel.AbsolutePosition.X + (ColorWheel.AbsoluteSize.X/2), ColorWheel.AbsolutePosition.Y + (ColorWheel.AbsoluteSize.Y/2))
				local distanceFromWheel = (mousePos - centreOfWheel).Magnitude

				if distanceFromWheel <= ColorWheel.AbsoluteSize.X/2 and buttonDown then
					ColorWheel_Picker.Position = UDim2.new(0, mousePos.X - ColorWheel.AbsolutePosition.X, 0, mousePos.Y - ColorWheel.AbsolutePosition.Y)

					updateColour(centreOfWheel)
				elseif movingSlider then
					DarknessPicker_Slider.Position = UDim2.new(.5, 0, 0, 
						math.clamp(
							mousePos.Y - DarknessPicker.AbsolutePosition.Y, 
							0, 
							DarknessPicker.AbsoluteSize.Y
						)
					)

					updateColour(centreOfWheel)
				end
			end)
            
            return Returned
		end

		return Functions, {
			Button = TextButton,
			Page = Page
		}
	end

	dragify(Items.Drag)

	return Functions, Gui
end

return App
