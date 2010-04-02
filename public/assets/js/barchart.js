(function($) {
  
  $.fn.barChart = function(table, options) {
    var defaults = {
      width: 800,
      height: 200,
      rowClass: ''
    };
    var options = $.extend(defaults, options);
    var chart = $(this);
    
    if (paper === undefined) {
      var paper = Raphael(chart.get(0), options.width, options.height);
    }
    
    $(table).hide();
    
    canvas = {
      draw: function() {
        var headers = $.makeArray($(table).find('tbody th'));
        var data = $(table).find('tbody tr td');
        var bottom_gutter = 0.175*paper.height;

        var largest = 0;
        data.each(function(i) {
          var current = parseInt($(this).text());
          if (current > largest) largest = current;
        });

        data.each(function(i) {
          var value = parseInt($(this).text());
          var height = value/largest*(paper.height-bottom_gutter)*.9;
          var width = paper.width/data.length;
          var rect = paper.rect(i*width, (paper.height-bottom_gutter)-height, width, height).attr({fill:"#9fd468", stroke:"#fff"});

          paper.text(i*width+width/2, (paper.height-bottom_gutter)*0.95-height, value).attr({fill:"#5A8136", "font-size":0.06*paper.height+"px"});
          paper.text(i*width+width/2, paper.height-bottom_gutter+0.09*paper.height, $(headers[i]).text()).attr({"font-size":0.05*paper.height+"px"});
        });
        
        return chart; 
      },
      
      redraw: function() {
        chart.empty();
        paper = Raphael(chart.get(0), options.width, options.height);
        canvas.draw();
        return chart;
      }
    };

    return canvas;
  };
  
})(jQuery);
