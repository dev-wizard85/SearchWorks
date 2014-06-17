/*
  JavaScript module to fetch preview content. `useCache` option enables/disables
  caching of fetched preview content in browser
 */

var PreviewContent = (function() {

  var useCache = true;
  window.previewCache = window.previewCache || {};


  function append(url, target) {
    var content = window.previewCache[url];

    if (useCache && typeof content !== 'undefined') {
      target.append(content);
    } else {
      fetchContentViaAjaxAndAppend(url, target);
    }
  }


  function fetchContentViaAjaxAndAppend(url, target) {
    var request = $.ajax({
      url: url,
      type: 'GET',
      dataType: 'html'
    });

    request.done(function(data) {
      target.append(data);
      if (useCache) window.previewCache[url] = data;
    });

    request.fail(function(jqXhr, textStatus) {
      console.log('GET request for ' + url + ' failed: ' + textStatus);
    });
  }


  return {
    append: function(url, target) {
      append(url, target);
    }
  }

}());