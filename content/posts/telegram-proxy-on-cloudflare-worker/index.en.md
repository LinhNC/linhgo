---
weight: 1
title: "Telegram proxy on Cloudflare Worker"
date: 2025-05-28T21:57:40+07:00
lastmod: 2025-05-28T21:57:40+07:00
draft: false
authors: ["Linh"]
description: "How to deploy a Telegram Worker Proxy on Cloudflare Workers with a custom domain."
featuredImage: "featured-image.webp"

tags: ["Tool","Telegram", "Cloudflare", "Worker"]
categories: ["development"]
header:
  number:
    enable: false
---

How to deploy a Telegram Worker Proxy on Cloudflare Workers with a custom domain.

<!--more-->

This guide walks you through deploying the [`telegram-bot-proxy`](https://github.com/tuanpb99/cf-worker-telegram/blob/main/telegram-bot-proxy.js) on [Cloudflare Workers](https://workers.cloudflare.com/) and connecting it to your **custom domain**.

## 📦 Prerequisites

* A Cloudflare account
* A domain added to Cloudflare
* Telegram Bot token and your Telegram secret path (from `setWebhook`)

---

## 1. 🛠️ Create the Worker

1. Go to your [Cloudflare dashboard](https://dash.cloudflare.com/)

2. Navigate to **Workers & Pages** → **Create Application**

3. Select the **"Workers"** tab → **Create Worker**

4. Give your worker a name, e.g. `telegram-proxy`

5. In the editor window:

   * Replace the default code with the Telegram proxy script from the GitHub repo:

     👉 **Paste this code** from [telegram-bot-proxy.js](https://github.com/tuanpb99/cf-worker-telegram/blob/main/telegram-bot-proxy.js) (Thanks to **tuanpb99**)

        ```javascript
      const TELEGRAM_API_BASE = "https://api.telegram.org"
      async function handleRequest(request) {
      const url = new URL(request.url);
         
      if (url.pathname === '/' || url.pathname === '') {
      return new Response(DOC_HTML, {
          headers: {
              'Content-Type': 'text/html;charset=UTF-8',
              'Cache-Control': 'public, max-age=3600',
          },
      });
      }
         
      // Extract the bot token and method from the URL path
      const pathParts = url.pathname.split('/').filter(Boolean);
      if (pathParts.length < 2 || !pathParts[0].startsWith('bot')) {
          return new Response('Invalid bot request format', { status: 400 });
      }
         
      // Reconstruct the Telegram API URL
      const telegramUrl = `${TELEGRAM_API_BASE}${url.pathname}${url.search}`;
         
      let body = undefined;
      if (request.method !== 'GET' && request.method !== 'HEAD') {
          try {
              body = await request.arrayBuffer();
          } catch (err) {
              return new Response(`Failed to read request body: ${err.message}`, { status: 400 });
          }
      }
         
      const proxyReq = new Request(telegramUrl, {
          method: request.method,
          headers: request.headers,
          body,
          redirect: 'follow',
      });
         
      try {
          const tgRes = await fetch(proxyReq);
          const res = new Response(tgRes.body, tgRes); // Clone Telegram response
          res.headers.set('Access-Control-Allow-Origin', '*');
          res.headers.set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
          res.headers.set('Access-Control-Allow-Headers', 'Content-Type');
          return res;
      } catch (err) {
          return new Response(`Error proxying request: ${err.message}`, { status: 500 });
      }
      }
         
      // Handle OPTIONS requests for CORS
      function handleOptions(request) {
          const corsHeaders = {
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
              'Access-Control-Allow-Headers': 'Content-Type',
              'Access-Control-Max-Age': '86400',
      };
         
      return new Response(null, {
          status: 204,
          headers: corsHeaders,
      });
      }
         
      // Main event listener for the worker
      addEventListener('fetch', event => {
      const request = event.request;
         
      if (request.method === 'OPTIONS') {
          event.respondWith(handleOptions(request));
      } else {
          event.respondWith(handleRequest(request));
      }
      });

     ```

6. Click **Save and Deploy**

---

## 2. 🌐 Add Your Custom Domain

1. Back in Cloudflare Dashboard → **Websites** → **Add a Site** (if not already added)

2. Choose your domain (e.g. `yourdomain.com`)

3. Go to **DNS** → Add DNS Records:

   * **Type**: A

   * **Name**: `@`

   * **Value**: `192.0.2.1` (placeholder, used for redirecting to Workers)

   * **Proxy status**: Proxied (Orange cloud ☁️)

   * **Type**: A

   * **Name**: `*`

   * **Value**: `192.0.2.1`

   * **Proxy status**: Proxied

4. Make sure your nameservers point to Cloudflare’s as shown in your domain setup panel

---

## 3. 🔗 Route Domain to the Worker

1. Go to **Workers & Pages** → Your Worker → **Triggers** tab
2. Scroll to **Routes**
3. Add:

   * `yourdomain.com/*`
   * `*.yourdomain.com/*`
4. Click **Save**

---

## 4. ✅ Final Test

1. Open your browser and go to https://yourdomain.com/ then you should see a simple HTML page indicating the worker is running.

2. Set your Telegram bot’s webhook to your new URL:

   ```bash
   curl "https://yourdomain.com/bot<YOUR_BOT_TOKEN>/<action>"
   ```

---

## 🎯 Conclusion

You’ve now:

✅ Deployed a Telegram proxy on Cloudflare Worker 

✅ Routed your domain to the Worker

✅ Secured your proxy with a secret path

✅ Connected your bot to use the new webhook

