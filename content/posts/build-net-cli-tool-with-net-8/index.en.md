---
weight: 1
title: "Building a .NET CLI Tool with .NET 8"
date: 2025-05-25T21:57:40+08:00
lastmod: 2025-05-25T21:57:40+08:00
draft: false
authors: ["Linh"]
description: "This guide walks you through creating a simple .NET CLI tool using .NET 8."
featuredImage: "featured-image.webp"

tags: [".NET","CLI Tool", "Tutorial"]
categories: ["development"]
header:
  number:
    enable: false
---
This guide walks you through creating a simple .NET CLI tool using .NET 8.

<!--more-->

## 🧱 Prerequisites

* [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
* A code editor (e.g., [Visual Studio Code](https://code.visualstudio.com/))
* Terminal or command prompt


## 📁 Step 1: Create a Console App

```bash
dotnet new console -n MyCliTool
cd MyCliTool
```


## ⚙️ Step 2: Update the `.csproj` for CLI Tool

Edit the `MyCliTool.csproj` file to make it a **global tool**:

```xml
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
    <PackAsTool>true</PackAsTool>
    <ToolCommandName>mycli</ToolCommandName>
  </PropertyGroup>

</Project>
```


## 💻 Step 3: Add Basic Command Logic

Edit `Program.cs`:

```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        if (args.Length == 0)
        {
            Console.WriteLine("Welcome to My CLI Tool!");
            Console.WriteLine("Usage: mycli <command>");
            return;
        }

        switch (args[0])
        {
            case "hello":
                Console.WriteLine("Hello from .NET 8 CLI Tool!");
                break;
            default:
                Console.WriteLine($"Unknown command: {args[0]}");
                break;
        }
    }
}
```


## 📦 Step 4: Pack the Tool

```bash
dotnet pack -c Release
```

This will generate a `.nupkg` file in the `bin/Release` folder.


## 🔧 Step 5: Install the Tool Locally

```bash
dotnet tool install --global --add-source ./nupkg MyCliTool
```

> Replace `./nupkg` with the actual folder path containing the `.nupkg` file.


## 🚀 Step 6: Run the CLI Tool

```bash
mycli
mycli hello
```

Expected output:

```bash
Welcome to My CLI Tool!
Hello from .NET 8 CLI Tool!
```


## 🧹 Step 7: Uninstall the Tool

```bash
dotnet tool uninstall --global mycli
```


## 🧩 Bonus: Add More Commands

You can add more `case` statements in the `switch` block to handle additional CLI commands.


## 📚 References

* [.NET CLI Tool Documentation](https://learn.microsoft.com/en-us/dotnet/core/tools/global-tools)
* [.NET SDK 8.0](https://dotnet.microsoft.com/download/dotnet/8.0)
