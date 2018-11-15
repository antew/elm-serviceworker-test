console.log("Service worker registered!");
self.addEventListener("fetch", function(event) {
  console.log("Got a fetch event!", event);

  if (event.request.url.indexOf("/ping") > -1) {
    console.log("Got ping");
    event.respondWith(
      new Response("Pong", {
        headers: { "Content-Type": "text/plain" }
      })
    );
  }
});
