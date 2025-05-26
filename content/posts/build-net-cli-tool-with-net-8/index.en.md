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
This guide walks you through creating a simple .NET CLI tool using .NET 8. The tool will fetch and display the current weather for any city you specify.

<!--more-->


# 🌤 Building a Weather CLI Tool with .NET 8

The goal is to create a simple yet powerful CLI tool named `weathercli` that fetches the current weather of any city using the [OpenWeatherMap API](https://openweathermap.org/api).

This guide walks you through everything step-by-step.

---

## 📋 Prerequisites

Before starting, ensure you have the following installed:

| Tool                                                           | Description                                                            |
| -------------------------------------------------------------- | ---------------------------------------------------------------------- |
| [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0) | Required to build and run .NET 8 apps                                  |
| OpenWeatherMap API Key                                         | [Sign up here](https://home.openweathermap.org/users/sign_up) for free |
| Terminal                                                       | CLI interface like Bash, PowerShell, or CMD                            |
| Optional: Visual Studio Code                                   | For easier coding and debugging                                        |

---

## 1️⃣ Create a Console App

Open your terminal and run:

```bash
dotnet new console -n WeatherCliTool
cd WeatherCliTool
```

This creates a new folder and scaffolds a basic console app.

---

## 2️⃣ Modify `.csproj` for CLI Tool Usage

Open `WeatherCliTool.csproj` and replace the content with:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
    <PackAsTool>true</PackAsTool>
    <ToolCommandName>weathercli</ToolCommandName>
  </PropertyGroup>
</Project>
```

Explanation:

| Property          | Purpose                                             |
| ----------------- | --------------------------------------------------- |
| `PackAsTool`      | Enables `dotnet pack` to generate a CLI tool        |
| `ToolCommandName` | Defines the command-line alias (e.g., `weathercli`) |
| `TargetFramework` | Targets .NET 8                                      |

---

## 3️⃣ Add NuGet Packages

Install the JSON and HTTP packages needed for calling APIs and handling responses:

```bash
dotnet add package System.Net.Http.Json
```

---

## 4️⃣ Write the Weather CLI Logic

### `Program.cs`:

```csharp
using System.Net.Http;
using System.Net.Http.Json;

class Program
{
    static async Task Main(string[] args)
    {
        if (args.Length == 0)
        {
            Console.WriteLine("Usage: weathercli <city>");
            Console.WriteLine("Example: weathercli Tokyo");
            return;
        }

        string city = string.Join(" ", args);
        string? apiKey = Environment.GetEnvironmentVariable("OPENWEATHER_API_KEY");

        if (string.IsNullOrWhiteSpace(apiKey))
        {
            Console.WriteLine("❌ ERROR: OpenWeatherMap API key not found.");
            Console.WriteLine("Set it using: export OPENWEATHER_API_KEY=your_key");
            return;
        }

        string url = $"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={apiKey}&units=metric";

        try
        {
            using HttpClient client = new();
            var weather = await client.GetFromJsonAsync<WeatherResponse>(url);

            if (weather is not null)
            {
                Console.WriteLine($"\n🌍 City: {weather.Name}");
                Console.WriteLine($"🌡 Temperature: {weather.Main.Temp}°C");
                Console.WriteLine($"🌦 Condition: {weather.Weather[0].Main} ({weather.Weather[0].Description})");
                Console.WriteLine($"💨 Wind: {weather.Wind.Speed} m/s\n");
            }
            else
            {
                Console.WriteLine("❌ Could not retrieve weather data.");
            }
        }
        catch (HttpRequestException)
        {
            Console.WriteLine("❌ Network error. Please check your internet connection.");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"❌ Unexpected error: {ex.Message}");
        }
    }
}

// API Response Models
public class WeatherResponse
{
    public string Name { get; set; }
    public MainWeather Main { get; set; }
    public List<WeatherInfo> Weather { get; set; }
    public Wind Wind { get; set; }
}

public class MainWeather
{
    public double Temp { get; set; }
}

public class WeatherInfo
{
    public string Main { get; set; }
    public string Description { get; set; }
}

public class Wind
{
    public double Speed { get; set; }
}
```

---

## 5️⃣ Set Your API Key Securely

Do **not** hardcode the API key. Instead, set it as an environment variable:

### 🐧 Linux / macOS:

```bash
export OPENWEATHER_API_KEY=your_api_key
```

### 🪟 Windows (CMD):

```cmd
setx OPENWEATHER_API_KEY your_api_key
```

### 🪟 Windows (PowerShell):

```powershell
$env:OPENWEATHER_API_KEY = "your_api_key"
```

---

## 6️⃣ Pack the Tool

Run this command to package the tool:

```bash
dotnet pack -c Release
```

The `.nupkg` file will be created in:

```
bin/Release/<project-name>.1.0.0.nupkg
```

---

## 7️⃣ Install the CLI Globally

Install your packed CLI as a global tool:

```bash
dotnet tool install --global --add-source ./nupkg WeatherCliTool
```

> Replace `./nupkg` with the path to your `.nupkg` folder.

---

## 8️⃣ Use the CLI Tool

Now you can call it from anywhere:

```bash
weathercli Hanoi
weathercli "New York"
```

Sample Output:

```
🌍 City: Hanoi
🌡 Temperature: 32.5°C
🌦 Condition: Clear (clear sky)
💨 Wind: 2.3 m/s
```

---

## 9️⃣ Uninstall the Tool

```bash
dotnet tool uninstall --global weathercli
```

---

## 🔧 Optional Enhancements

| Feature              | Description                               |
| -------------------- | ----------------------------------------- |
| `--help` argument    | Show usage instructions                   |
| `System.CommandLine` | Advanced argument parsing                 |
| `Spectre.Console`    | Rich terminal output                      |
| Cache                | Store recent queries to avoid API limits  |
| Unit conversion      | Add support for Fahrenheit/Imperial units |
| JSON output          | Add `--json` flag for scripting support   |

---

## 📚 Resources

* [OpenWeatherMap Docs](https://openweathermap.org/current)
* [System.Net.Http.Json](https://learn.microsoft.com/en-us/dotnet/api/system.net.http.json)
* [Creating .NET Tools](https://learn.microsoft.com/en-us/dotnet/core/tools/global-tools)

---

## ✅ Summary Table

| Step | Task                                    |
| ---- | --------------------------------------- |
| 1    | Create console app                      |
| 2    | Configure `.csproj`                     |
| 3    | Implement CLI logic                     |
| 4    | Add HTTP & JSON handling                |
| 5    | Secure API key via environment variable |
| 6    | Pack using `dotnet pack`                |
| 7    | Install with `dotnet tool install`      |
| 8    | Use with `weathercli <city>`            |
| 9    | Enhance for real-world usage            |

---

Let me know if you want a version of this guide exported as a PDF, blog post layout, or even published as a GitHub template!
