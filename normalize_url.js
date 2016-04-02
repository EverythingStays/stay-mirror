#! /usr/bin/env node

// Slight modified source from
// https://github.com/npm/normalize-git-url/blob/a191a5a48f491fb898741d65d9fad20b86b95747/normalize-git-url.js
// Modified: returns URL directly instead of return both URL and branch

var url = require('url')

if (!process.argv[2]) {
  console.log('Missing URL!')
}

console.log(normalize(process.argv[2]))

function normalize (u) {
  var parsed = url.parse(u)
  // If parsing actually alters the URL, it is almost certainly an
  // scp-style URL, or an invalid one.
  var altered = u !== url.format(parsed)

  // git is so tricky!
  // if the path is like ssh://foo:22/some/path then it works, but
  // it needs the ssh://
  // If the path is like ssh://foo:some/path then it works, but
  // only if you remove the ssh://
  if (parsed.protocol) {
    parsed.protocol = parsed.protocol.replace(/^git\+/, '')
  }

  // figure out what we should check out.
  parsed.hash = ''

  var returnedUrl
  if (altered) {
    if (u.match(/^git\+https?/) && parsed.pathname.match(/\/?:[^0-9]/)) {
      returnedUrl = u.replace(/^git\+(.*:[^:]+):(.*)/, '$1/$2')
    } else {
      returnedUrl = u.replace(/^(?:git\+)?ssh:\/\//, '')
    }
    returnedUrl = returnedUrl.replace(/#[^#]*$/, '')
  } else {
    returnedUrl = url.format(parsed)
  }

  return returnedUrl
}

