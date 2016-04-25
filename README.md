
### Installation

```
bundle install
npm install -g gulp
npm install
```

### Development

```
npm start
```

- Automatically re-compiles on changes
- Supports coffee, cjsx, scss
- Live reload of both CSS and JS (keep console open however, may sometimes fail to refresh)

### Production

The `prod-server` gulp task will be run to serve production. This compiles assets on deploy and the serves static files using `gulp-connect`.

Non-prod environments (ENV['NODE_ENV'] != 'production') will present password prompt for user/pass dev/dev.
