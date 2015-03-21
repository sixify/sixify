$(function () {
    var seriesOptions = [],
        // create the chart when all data is loaded
        createChart = function () {

            $('#forex-container').highcharts('StockChart', {

                rangeSelector: {
                    selected: 4
                },

                yAxis: {
                    labels: {
                        formatter: function () {
                            return (this.value > 0 ? ' + ' : '') + this.value + '%';
                        }
                    },
                    plotLines: [{
                        value: 0,
                        width: 2,
                        color: 'silver'
                    }]
                },
								//xAxis: {
									//type: 'datetime',
								//},

                plotOptions: {
                    series: {
                        compare: 'percent'
                    }
                },

                tooltip: {
                    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
                    valueDecimals: 2
                },

                series: seriesOptions
            });
        };

        $.getJSON('data/sixify_forex2.json', function (data) {

					var maxPairs = 15;
					var pairsCount = 0;
					for(pair in data) {
						console.log(pair);
						seriesOptions.push({
								name: pair,
								data: data[pair],
						});
						if(maxPairs == pairsCount) {
							break;
						}
						pairsCount += 1;
					}
					createChart();
        });
});
