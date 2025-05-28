---
weight: 1
title: "n8n: Workflow Automation Tool Overview"
date: 2025-05-25T21:57:40+08:00
lastmod: 2025-05-25T21:57:40+08:00
draft: false
authors: ["Linh"]
description: "Introduction to n8n, a powerful workflow automation tool with over 500 integrations and AI capabilities."
featuredImage: "featured-image.webp"

tags: ["n8n","AI", "Automation", "Workflow"]
categories: ["development"]
header:
  number:
    enable: false
---

Here is an overview of **n8n**, a powerful workflow automation tool that allows you to connect various applications and services seamlessly. This guide will introduce you to n8n, its features, installation methods, and a simple example workflow.
<!--more-->


## What is n8n?
[n8n](https://n8n.io/) is a **fair-code** workflow automation tool that allows users to integrate various applications and services seamlessly. It provides a **visual workflow builder** with the flexibility to use **custom code** when needed. Key features include:
- **Self-hosted & Cloud Options**: Deploy on-premises or use the hosted version.
- **Over 500 Integrations**: Connect with popular apps like Slack, GitHub, and databases.
- **AI Integration**: Easily incorporate AI models into workflows.
- **Debugging & Logging**: Re-run single steps, replay data, and debug efficiently.
- **Security & Control**: Supports SSO, RBAC permissions, and encrypted secret stores.

## Installation & Running n8n
You can install and run n8n using **Docker** or **npm**.

### Using Docker
```sh
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n
```
This command starts n8n in a Docker container, exposing it on port **5678**.

### Using npm
```sh
npm install -g n8n
n8n start
```
This installs n8n globally and starts the application.

## Example Workflow: Webhook to Slack
This example demonstrates a workflow where:
1. A **Webhook** node receives a POST request.
2. A **Slack** node sends a message.

### Step 1: Create a Webhook Node
- Add a **Webhook** node in n8n.
- Set the **HTTP Method** to `POST`.
- Copy the generated **Webhook URL**.

{{< image src="/webhook.webp" caption="WebHook (`image`)" src_s="/webhook.webp" src_l="/webhook.webp" >}}
![Webhook Node](https://github.com/n8n-io/n8n/blob/master/docs/images/webhook-node.png)

### Step 2: Create a Slack Node
- Add a **Slack** node.
- Configure it with your **Slack API Token**.
- Set the **Channel** and **Message**.

![Slack Node](https://github.com/n8n-io/n8n/blob/master/docs/images/slack-node.png)

### Step 3: Connect the Nodes
- Link the **Webhook** node to the **Slack** node.
- Ensure the **Slack node** uses data from the Webhook.

### Step 4: Test the Workflow
Send a test request using `curl`:
```sh
curl -X POST -H "Content-Type: application/json" \
  -d '{"text": "Hello from n8n!"}' \
  <WEBHOOK_URL>
```
If successful, the message appears in Slack.

## Exporting the Workflow
You can export the workflow as **JSON**:
```json
{
  "nodes": [
    { "name": "Webhook", "type": "Webhook", "parameters": {} },
    { "name": "Slack", "type": "Slack", "parameters": {} }
  ],
  "connections": { "Webhook": { "main": [{ "node": "Slack" }] } }
}
```

## Slack Message Example
The Slack message will look like:
```
Hello from n8n!
```

## Useful Links
- [n8n Documentation](https://docs.n8n.io/)
- [Slack API](https://api.slack.com/)
- [n8n Community Forum](https://community.n8n.io/)
```
