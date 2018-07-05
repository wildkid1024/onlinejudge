<div class="container"> 
  <div class="row"> 
        <div class="row text-center"> </div> 
        <div id="https-alert" class="alert alert-info" role="alert" style="">通知
          <a class="alert-link" href="">链接</a> 
        </div> 
        {{/*<div class="welcome"> */}}
          {{/*<p></p>*/}}
          {{/*<h3 style="text-align:center;padding-top:10px;">Welcome to SDAU OnlineJudge!</h3>*/}}
          {{/*<p></p> */}}
          {{/*<p class="text">&nbsp;&nbsp;Please <a href="User/register">register</a> or <a href="Login/login">log in</a> to practice programming skills or participate in a <a href="Contest/contestlist">contest</a>.<br /> &nbsp;&nbsp;Anonymous visitors (without logging in ) can only check <a href="Index/problemlist">Problems</a>,<a href="User/standings"> Standings</a>, and<a href="Solution/status"> Status</a>.<br /> &nbsp;&nbsp;As a registered user, you can submit your source code and see if your solution is correct. <br /> &nbsp;&nbsp;Please use Chrome, Firefox, IE (above IE9) or other browsers supporting Bootstrap 3.<br /> &nbsp;&nbsp;Should you have any questions, please <a href="">contact</a> us. </p> <br /> */}}
        {{/*</div> */}}
        <div class="row"> 
          <div id="chart" style="width: 100%; height: 500px; -moz-user-select: none; position: relative; background: transparent none repeat scroll 0% 0%;" _echarts_instance_="ec_1524372908488">
            <div style="position: relative; overflow: hidden; width: 1200px; height: 500px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;">
              <canvas style="position: absolute; left: 0px; top: 0px; width: 1200px; height: 500px; -moz-user-select: none; padding: 0px; margin: 0px; border-width: 0px;" width="1200" height="500" data-zr-dom-id="zr_0"></canvas>
            </div>
          </div> 
          <script language="javascript" type="text/javascript" src="static/js/echarts.js"></script> 
          <script type="text/javascript">
                        //基于准备好的dom，初始化echarts实例
                        var myChart = echarts.init(document.getElementById('chart'));

                        var day_list = [
                                "2018-04-08","2018-04-09","2018-04-10","2018-04-11","2018-04-12","2018-04-13","2018-04-14","2018-04-15","2018-04-16","2018-04-17","2018-04-18","2018-04-19","2018-04-20","2018-04-21",                                ];
                        var submit_data = [
                                4987,11012,5173,12093,10951,9107,11999,11473,12141,7888,15496,11753,7532,10837,                                ];
                        // 指定图表的配置项和数据
                        var option = {
                            title: {
                                text: '近两周提交量统计'
                            },
                            tooltip: {},
                            legend: {
                                data:['提交']
                            },
                            xAxis: {
                                name:'日期',
                                data: day_list
                            },
                            yAxis: { },
                            series: [{
                                name: '提交',
                                type: 'bar',
                                data: submit_data
                            }],
                            color:['#56A5EB','#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570']
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        myChart.setOption(option);
                    </script> 
    </div>
  </div>
</div>


