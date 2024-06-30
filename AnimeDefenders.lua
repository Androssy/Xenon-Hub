local cloneref = cloneref or function(Obj) return Obj end

local Androssy, Utils = {
    Services = setmetatable({}, {
        __index = function(Self, Index)
            local Service = cloneref(game:GetService(Index))
            if Service then
                Self[Index] = Service
            end
            return Service
        end
    }),
    Elements = {
        Windows = {},
        ImageButton = {},
    },
    Font = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
}, {};

local Services, Elements = Androssy.Services, Androssy.Elements

local Players = Services.Players
local HttpService = Services.HttpService
local UserInputService = Services.UserInputService
local RunService = Services.RunService

local LocalPlayer = Players.LocalPlayer
local INew = Instance.new

function Utils:Render(ObjType, Properties, Children)
    local Passed, Statement = pcall(function()
        local Object = INew(ObjType)

        for Property, Value in pairs(Properties) do
            Object[Property] = Value
        end

        if Children then
            for Index, Child in pairs(Children) do
                Child.Parent = Object
            end
        end

        return Object
    end)

    if Passed then
        return Statement
    else
        warn(Statement)
        return nil
    end
end

function Utils:SafeCall(Function, ...)
    local Passed, Statement = pcall(Function, ...)
    if not Passed then
        warn(Statement)
    end
end

function Androssy:Window(Properties)
    local Properties = Properties or {}

    local Window = {
        ItemHolder = nil,
        Content = {
            Title = Properties.Title or "Window",
            Description = Properties.Description or "Window Description",
        }
    }

    local AnimeDefenders = Utils:Render("ScreenGui", {
        Name = "Anime Defenders",
        DisplayOrder = -9999,
        IgnoreGuiInset = true,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        Enabled = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })

    local MainFrame = Utils:Render("Frame", {
        Name = "MainFrame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(0, 0, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.4, 0.6),
    })

    local MainConner = Utils:Render("UICorner", {
        Name = "MainConner",
        Parent = MainFrame,
    })

    local NavbarFrame = Utils:Render("Frame", {
        Name = "NavbarFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42),
    })

    local NavbarTitle = Utils:Render("Frame", {
        Name = "NavbarTitle",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(16, 0),
        Size = UDim2.new(1, -16, 1, 0),
    })

    local NavList = Utils:Render("UIListLayout", {
        Name = "NavList",
        Padding = UDim.new(0, 5),
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = NavbarTitle,
    })

    local NavTitle = Utils:Render("TextLabel", {
        Name = "NavTitle",
        FontFace = Androssy.Font,
        RichText = true,
        Text = Window.Content.Title,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.fromScale(0, 1),
        Parent = NavbarTitle,
    })

    local NavDesc = Utils:Render("TextLabel", {
        Name = "NavDesc",
        FontFace = Androssy.Font,
        RichText = true,
        Text = Window.Content.Description,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 12,
        TextTransparency = 0.4,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.fromScale(0, 1),
        Parent = NavbarTitle,
    })

    NavbarTitle.Parent = NavbarFrame

    local UnderlineFrame = Utils:Render("Frame", {
        Name = "UnderlineFrame",
        BackgroundColor3 = Color3.fromRGB(58, 58, 58),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.new(1, 0, 0, 1),
        Parent = NavbarFrame,
    })

    NavbarFrame.Parent = MainFrame

    local ItemCanvas = Utils:Render("CanvasGroup", {
        Name = "ItemCanvas",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(5, 50),
        Size = UDim2.new(1, 0, 1, -50),
    })

    local ItemFrame = Utils:Render("ScrollingFrame", {
        Name = "ItemFrame",
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BottomImage = "rbxassetid://6889812791",
        CanvasSize = UDim2.fromOffset(0, 527),
        MidImage = "rbxassetid://6889812721",
        ScrollBarImageTransparency = 0.95,
        ScrollBarThickness = 3,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        TopImage = "rbxassetid://6276641225",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    })

    local ItemList = Utils:Render("UIListLayout", {
        Name = "ItemList",
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = ItemFrame,
    })

    local ItemPadding = Utils:Render("UIPadding", {
        Name = "ItemPadding",
        PaddingBottom = UDim.new(0, 1),
        PaddingLeft = UDim.new(0, 1),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 1),
        Parent = ItemFrame,
    })

    ItemFrame.Parent = ItemCanvas
    ItemCanvas.Parent = MainFrame

    local ImgBackground = Utils:Render("ImageLabel", {
        Name = "ImgBackground",
        Image = "rbxassetid://17648396865",
        ImageTransparency = 0.5,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 0,
    })

    local ImgConner = Utils:Render("UICorner", {
        Name = "ImgConner",
        Parent = ImgBackground,
    })

    ImgBackground.Parent = MainFrame

    MainFrame.Parent = AnimeDefenders

    local BlackFrame = Utils:Render("Frame", {
        Name = "BlackFrame",
        BackgroundColor3 = Color3.fromRGB(10, 10, 10),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 0,
        Parent = AnimeDefenders,
    })

    function Window:Destory()
        AnimeDefenders:Destroy()
    end

    function Window:Close()
        AnimeDefenders.Enabled = false
    end

    function Window:Open()
        AnimeDefenders.Enabled = true
    end

    function Window:Toggle()
        AnimeDefenders.Enabled = not AnimeDefenders.Enabled
    end

    function Window:IsOpen()
        return AnimeDefenders.Enabled
    end

    AnimeDefenders.Parent = LocalPlayer.PlayerGui
    Window.ItemHolder = ItemFrame

    return setmetatable(Window, {
        __index = Elements.Windows
    })
end

function Elements.Windows:ImageButton(Properties)
    local Properties = Properties or {}
    local Content = {
        Window = self,
        Image = Properties.Image or "rbxassetid://16637242593",
        Title = Properties.Title or "Item",
    }

    local ImageHolder = Utils:Render("TextButton", {
        Name = "ImageHolder",
        Text = "",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 14,
        AutoButtonColor = false,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Color3.fromRGB(120, 120, 120),
        BackgroundTransparency = 0.87,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        LayoutOrder = 7,
        Position = UDim2.fromScale(-0.0562, 0.00625),
        Size = UDim2.fromScale(1, 0),
        Parent = Content.Window.ItemHolder,
    })

    local ImageConner = Utils:Render("UICorner", {
        Name = "ImageConner",
        CornerRadius = UDim.new(0, 4),
        Parent = ImageHolder,
    })

    local ImageStroke = Utils:Render("UIStroke", {
        Name = "ImageStroke",
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.fromRGB(35, 35, 35),
        Transparency = 0.6,
        Parent = ImageHolder,
    })

    local Icon = Utils:Render("ImageLabel", {
        Name = "Icon",
        Image = Content.Image,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.761, 0.103),
        Size = UDim2.fromOffset(95, 95),
    })

    local IconConner = Utils:Render("UICorner", {
        Name = "IconConner",
        Parent = Icon,
    })

    Icon.Parent = ImageHolder

    local ImageFrame = Utils:Render("Frame", {
        Name = "ImageFrame",
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(8, 0),
        Size = UDim2.new(0.79, -28, 0.857, 0),
    })

    local ImageFrameList = Utils:Render("UIListLayout", {
        Name = "ImageFrameList",
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Parent = ImageFrame,
    })

    local ImageFrameConner = Utils:Render("UIPadding", {
        Name = "ImageFrameConner",
        PaddingBottom = UDim.new(0, 13),
        PaddingTop = UDim.new(0, 13),
        Parent = ImageFrame,
    })

    local ImageTitle = Utils:Render("TextLabel", {
        Name = "ImageTitle",
        FontFace = Androssy.Font,
        Text = Content.Title,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 20,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Position = UDim2.fromScale(-6.74e-08, 0),
        Size = UDim2.new(0.77, 0, 0, 100),
        Parent = ImageFrame,
    })

    ImageFrame.Parent = ImageHolder

    function Content:Set(Properties)
        local Properties = Properties or {}
        local Content = {
            Image = Properties.Image or self.Image,
            Title = Properties.Title or self.Title,
        };

        Icon.Image = Content.Image
        ImageTitle.Text = Content.Title

        return setmetatable(Content, {
            __index = Elements.ImageButton
        })
    end

    return setmetatable(Content, {
        __index = Elements.ImageButton
    })
end

return Androssy
