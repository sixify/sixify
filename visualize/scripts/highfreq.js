$(function () {    
    var seriesOptions = [],
        seriesCounter = 0,        
        // create the chart when all data is loaded
        createChart = function () {

            $(function () {
                $('#highfreq-container').highcharts({
                
                    credits: false,

                    title: {
                        text: "",
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
                console.log(series_name);
                console.log(data);
                var series = {
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
    // $.each(names, function (i, name) {

    //     $.getJSON('http://www.highcharts.com/samples/data/jsonp.php?filename=' + name.toLowerCase() + '-c.json&callback=?',    function (data) {

    //         seriesOptions[i] = {
    //             name: name,
    //             data: data
    //         };

    //         // As we're loading the data asynchronously, we don't know what order it will arrive. So
    //         // we keep a counter and create the chart when all the data is loaded.
    //         seriesCounter += 1;

    //         if (seriesCounter === names.length) {
    //             createChart();
    //         }
    //     });
    // });
});


// d3.csv("data/sixify_bitstamp_btcusd.csv", function (data) {  
