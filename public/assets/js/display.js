$(function() {
  setInterval(function() {
    $.ajax({
      type: 'GET',
      dataType: 'json',
      url: '/votes/counts',
      success: function(data) {
        var total = data["total"];
        var max = 0;
        $.each(data["candidates"], function(key, value) {
          if (max <= value) max = value;
        });
        if (total != 0) {
          $.each(data["candidates"], function(key, value) {
            $("#candidate-" + key + " .percentage").html(Math.round((value/total*100)*100)/100 + "%");
            $("#candidate-" + key + " .percentage").css({ bottom: (value/max*400) + "px" });
            $("#candidate-" + key + " .bar").css({ height: (value/max)*400 + "px" });
          });
        }
      }
    });
  }, 3000);
});
