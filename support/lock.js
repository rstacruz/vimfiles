/*
 * makes a "locked" version of bower.json, where versions of `dependencies` are
 * locked to be unambiguous.
 */

var Fs = require('fs');
var Path = require('path');
var extend = require('util')._extend;

var out = readJson('bower.json');
extend(out.dependencies, out.devDependencies || {});
extend(out.dependencies, getLockedDependencies());
delete out.devDependencies;

console.log(JSON.stringify(out, null, 2));

/*
 * Get locked dependencies
 */

function getLockedDependencies () {
  var dependencies = {};
  var bundlePath = getBowerPath();
  var bundles = Fs.readdirSync(bundlePath);

  bundles.forEach(function (bundle) {
    try {
      var
        bowerFile = Path.join(bundlePath, bundle, '.bower.json'),
        data = readJson(bowerFile);

      // Read the .bower.json file
      var
        name = data.name,
        target = data._target,
        source = data._originalSource,
        res = data._resolution.type;

      // if the resolution is ambiguous, lock the commit instead
      if (res === 'branch')
        target = data._resolution.commit;

      dependencies[name] = source + "#" + target;
    } catch (e) {}
  });

  return dependencies;
}

/*
 * Helpers
 */

function getBowerPath () {
  try {
    var bowerrc = readJson('.bowerrc');
    if (bowerrc && bowerrc.directory)
      return bowerrc.directory;
  } catch (e) {}

  return 'bower_components';
}

function readJson (file) {
  return JSON.parse(Fs.readFileSync(file, 'utf-8'));
}
