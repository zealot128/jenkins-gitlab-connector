# Connector for gitlab and jenkins for automatic build triggering

Gitlab send's post somewhere, but jenkins needs GET. Here is the missing piece inbetween.


## Installation

```ruby
bundle
cp config.yml.example config.yml
# edit config.yml

bash start.sh
```

Starts a mini-app on HOST:3850.

Put the URL in Gitlab's post-receive hooks, like http://myserver:3850/.

The app will trigger a authenticated GET request to the jenkins Server. Therefore, auth credentials of a user are required, which can build the app.

We use 2 environments and have different behavior for each:
* pushing to staging triggers a build, which tests, set up staging server, generate documentation etc.
* pushing to master triggers a deployment from the latest master branch

this can be achieved by specifing different projects to contact depending on the pushed branch
