IronWorker and DocRaptor Example
================================

An example how to combine [DocRaptor][1]'s async feature and [IronWorker][2].

## Goal
1. Send html to [DocRaptor][1] using the [asynchronous job feature](https://docraptor.com/documentation#api_async).
2. In return we get a `status_id`
3. Send status_id, name, email and title of document to an [IronWorker][2] worker
4. Pull [DocRaptor][1] with status_id until document is ready for download
5. Download pdf from [DocRaptor][1]
6. Create mail, attach pdf and send

## Prerequisites
* An account and project with [Iron.io][3]
* An account with [DocRaptor][1]
* Email credentials: user, password, smtp-host, port and sender. Works well with GMail.

## Quickstart
1. Create a free account with [Iron.io][3]
2. Enter your [Hud](https://hud.iron.io/dashboard) and create a project
3. Get your credentials by clicking on the litte key
4. Edit [iron.json](../master/iron.json) and put in your credentials
5. Signup for an api-key at [DocRaptor][https://docraptor.com/signup]
6. Put your api-key in [config.json - DOCRAPTOR_TOKEN](../master/config.json)
7. Put your mail credentials in [config.json](../master/config.json)
8. `./deploy`
9. `./enqueue_pdf --to you@foo.com  --name 'The Architect'`

## In the wild

We, [Upptec](http://upptec.se), use this in Rails by rendering to string and sending to [DocRaptor][1]
```ruby
# in a controller
respond_to do |format|
  format.html {render}
  format.pdf do
  	document_content = render_to_string(layout: "pdf_document") # different layout for pdf
  	... # i.e. doing as in enqueue-file
  end
end
```

## Notes
Combining [IronMQ](http://www.iron.io/mq) with [IronWorker][2] using [push queues](http://dev.iron.io/mq/reference/push_queues/) and [webhooks](http://dev.iron.io/worker/webhooks/) is a perfect combo for this scenario.

### About Upptec
Upptec provides valuation-as-a-service to the largest insurance companies in Sweden.

[1]: https://docraptor.com
[2]: http://www.iron.io/worker
[3]: http://www.iron.io/
