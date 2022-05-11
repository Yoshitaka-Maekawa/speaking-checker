import Chart from 'chart.js/auto';

var ctx = document.getElementById("myChart");
var chart_params = {
  type: 'radar',
  data: {
    labels: [`発音の正確さ ${gon.accuracy_score}点`, `発音の流暢さ ${gon.fluency_score}点`, `発音の完成度 ${gon.completeness_score}点`],
    datasets: [{
      backgroundColor: "rgba(236, 23, 183,0.5)",
      borderColor: "rgba(245, 40, 150,1)",
      borderWidth: 2,
      pointRadius: 1.5,
      data: [
        gon.accuracy_score,
        gon.fluency_score,
        gon.completeness_score
      ]
    }]
  },
  options: {
    aspectRatio: 2,
    plugins: {
      legend: {
        display: false
      },
    },
    scales: {
      r: {
        suggestedMin: 50,
        max: 100,
        angleLines: {
          color: "rgba(238, 130, 238, 0.65)"
        },
        grid: {
          color: "rgba(238, 130, 238, 1)",
          lineWidth: 2.4
        },
        pointLabels: {
          color: "rgba(0,0,0,1)",
          font: {
            size: 16.5,
            weight: 'bold'
          },
        },
        ticks: {
          maxTicksLimit: 3,
          stepSize: 25,
          color: "rgba(0,0,0,1)",
          font: {
            weight: 'bold'
          }
        }
      }
    }
  }
}
var myChart = new Chart(ctx, chart_params);
