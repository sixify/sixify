$(function () {    
    var seriesOptions = [],
        seriesCounter = 0,
        parseName = function(filename) {            
            var re = new RegExp("_(.*?).txt");
            var res = filename.match(re);
            // console.log(res[1]);
            return res[1];
        },
        // create the chart when all data is loaded
        createChart = function () {

            $(function () {
                $('#highfreq-container').highcharts({
                
                    credits: false,

                    title: {
                        text: "Distributed market prices vs. relative strength",
                    },

                    xAxis: {
                        type: "datetime",
                    },

                    labels: {
                        formatter: function() {
                            // return Highcharts.dateFormat('%a %d %b', this.value);
                            return Highcharts.dateFormat('%H:%M:%S', this.value);
                        }
                    },

                    // tooltip: {
                    //     pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
                    //     valueDecimals: 2
                    // },

                    series: seriesOptions,
                });

                // the button action
                var chart = $('#container').highcharts(),
                    $button = $('#button');
                $button.click(function () {
                    var series = chart.series[0];
                    if (series.visible) {
                        series.hide();
                        $button.html('Show series');
                    } else {
                        series.show();
                        $button.html('Hide series');
                    }
                });
            });


            // $('#inputfeeds-container').highcharts('StockChart', {

            //     credits: false,

            //     rangeSelector: {
            //         selected: 4
            //     },

            //     yAxis: {
            //         labels: {
            //             formatter: function () {
            //                 return (this.value > 0 ? ' + ' : '') + this.value + '%';
            //             }
            //         },
            //         plotLines: [{
            //             value: 0,
            //             width: 2,
            //             color: 'silver'
            //         }]
            //     },

            //     plotOptions: {
            //         series: {
            //             compare: 'percent'
            //         }
            //     },

            //     tooltip: {
            //         pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
            //         valueDecimals: 2
            //     },

            //     series: seriesOptions
            // });
        };

    $.getJSON('data/sixify_highfreq.json', function (series_files) {        
        $.each(series_files, function (i, series_name) {
            $.getJSON(series_name, function (data) {
                // console.log(series_name);

                // console.log(data);
                var series = {
                    name: parseName(series_name),
                    data: data['price']
                };
                seriesOptions.push(series);
                seriesCounter += 1;

                if (seriesCounter === series_files.length) {
                    console.log('create chart');
                    createChart();
                }
            });
        });
    })
});


// d3.csv("data/sixify_bitstamp_btcusd.csv", function (data) {  
