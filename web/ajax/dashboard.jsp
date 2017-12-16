<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    
Calendar cal1 = Calendar.getInstance();
cal1.set(2017, 0, 1);
Calendar cal2 = Calendar.getInstance();
String[] incomes = new String[3];
String[] counts = new String[2];
String[] qc = new String[6];
Random rand = new Random();
for(int i=0;cal1.before(cal2);i++){
    long t = cal1.getTimeInMillis();
    for(int j=0;j<incomes.length;j++){
        if(i > 0)  incomes[j] += ",";
        else incomes[j] = "";
        int amt = rand.nextInt(50)+10*(i+1);
        incomes[j] += "["+t+","+amt+"]";
    }
    for(int j=0;j<counts.length;j++){
        if(i > 0)  counts[j] += ",";
        else counts[j] = "";
        int amt = rand.nextInt(500)+50*(i+1);
        counts[j] += "["+t+","+amt+"]";
    }
    for(int j=0;j<qc.length;j++){
        if(i > 0)  qc[j] += ",";
        else qc[j] = "";
        int amt = 0;
        if(j == 1) amt = 10;
        else if(j == 2) amt = 5;
        else if(j == 3) amt = 0;
        else if(j == 4) amt = -5;
        else if(j == 5) amt = -10;
        else amt = rand.nextInt(20)-10;
        qc[j] += "["+t+","+amt+"]";
    }
    cal1.add(Calendar.DATE, 10);
}
System.out.println("var trgt = ["+incomes[0]+"]\n,prft = ["+incomes[1]+"]\n,sgnups = ["+incomes[2]+"],");
%>
<style>
    #sparks li h5 {
        margin: 0px 0 0 0 !important;
    }
</style>
<div class="row">
	<div class="col-xs-12 col-sm-5 col-md-5 col-lg-8">
		<ul id="sparks" class="">
			<li class="sparks-info">
				<h5> <%=trs.t("შემოსავლები")%> <span class="txt-color-blue">38 022</span></h5>
				<div class="sparkline txt-color-blue hidden-mobile hidden-md hidden-sm">
					1300, 1877, 2500, 2577, 2000, 2100, 3000, 2700, 3631, 2471, 2700, 3631, 2471
				</div>
			</li>
			<li class="sparks-info">
				<h5> <%=trs.t("კომერციული შეკვეთები")%> <span class="txt-color-purple"><i class="fa fa-arrow-circle-up"></i>&nbsp;5%</span></h5>
				<div class="sparkline txt-color-purple hidden-mobile hidden-md hidden-sm">
					110,150,300,130,400,240,220,310,220,300, 270, 210
				</div>
			</li>
			<li class="sparks-info">
				<h5> <%=trs.t("სულ შეკვეთები")%> <span class="txt-color-greenDark"><i class="fa fa-shopping-cart"></i>&nbsp;2447</span></h5>
				<div class="sparkline txt-color-greenDark hidden-mobile hidden-md hidden-sm">
					110,150,300,130,400,240,220,310,220,300, 270, 210
				</div>
			</li>
		</ul>
	</div>
</div>
<!-- widget grid -->
<section id="widget-grid" class="">

	<!-- row -->
	<div class="row">
		<article class="col-sm-12">
			<!-- new widget -->
			<div class="jarviswidget" id="wid-id-0" data-widget-togglebutton="false" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-deletebutton="false">
				<!-- widget options:
				usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

				data-widget-colorbutton="false"
				data-widget-editbutton="false"
				data-widget-togglebutton="false"
				data-widget-deletebutton="false"
				data-widget-fullscreenbutton="false"
				data-widget-custombutton="false"
				data-widget-collapsed="true"
				data-widget-sortable="false"

				-->
				<header>
					<span class="widget-icon"> <i class="glyphicon glyphicon-stats txt-color-darken"></i> </span>
					<h2><%=trs.t("სტატისტიკა")%> </h2>

					<ul class="nav nav-tabs pull-right in" id="myTab">
						<li class="active">
							<a data-toggle="tab" href="#s1"><i class="fa fa-check-square-o"></i> <span class="hidden-mobile hidden-tablet"><%=trs.t("ხარისხი")%></span></a>
						</li>

						<li>
							<a data-toggle="tab" href="#s2"><i class="fa fa-stethoscope "></i> <span class="hidden-mobile hidden-tablet"><%=trs.t("კვლევები")%></span></a>
						</li>

						<li>
							<a data-toggle="tab" href="#s3"><i class="fa fa-dollar"></i> <span class="hidden-mobile hidden-tablet"><%=trs.t("შემოსავლები")%></span></a>
						</li>
					</ul>

				</header>

				<!-- widget div-->
				<div class="no-padding">
					
					<!-- end widget edit box -->

					<div class="widget-body">
						<!-- content -->
						<div id="myTabContent" class="tab-content">
							<div class="tab-pane fade active in padding-10 no-padding-bottom" id="s1">
								<div class="row no-space">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
										
										<div id="updating-chart" class="chart-large txt-color-blue"></div>

									</div>
									<div class="col-xs-12 col-sm-12 col-md-3 col-lg-3 show-stats">
                                                                            <div class="row">
                                                                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                                                                    <div style="padding-left: 20px;" class="font-md"><%=trs.t("გარე ხარისხის კონტროლის პროცენტული გადახრები")%> (Levey–Jennings)<br></div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="legend1"></div>
                                                                            </div>
                                                                            
										

									</div>
								</div>

								

							</div>
							<!-- end s1 tab pane -->

							<div class="tab-pane fade" id="s2">
								<div class="widget-body-toolbar bg-color-white">

									<form class="form-inline" role="form">

										<div class="form-group">
											<label class="sr-only" for="s123"><%=trs.t("საიდან")%></label>
											<input type="email" class="form-control input-sm" id="s123" placeholder="<%=trs.t("საიდან")%>">
										</div>
										<div class="form-group">
											<input type="email" class="form-control input-sm" id="s124" placeholder="<%=trs.t("სადამდე")%>">
										</div>

										<div class="btn-group hidden-phone pull-right hidden-xs">
											<a class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown"><i class="fa fa-cog"></i> <%=trs.t("ექსპორტი")%> <span class="caret"> </span> </a>
                                                                                        <ul class="dropdown-menu pull-right">
                                                                                                <li>
                                                                                                        <a href="javascript:void(0);"><i class="fa fa-file-pdf-o"></i> PDF</a>
                                                                                                </li>
                                                                                                <li>
                                                                                                        <a href="javascript:void(0);"><i class="fa fa-file-excel-o"></i> XLS</a>
                                                                                                </li>
                                                                                        </ul>
										</div>

									</form>

								</div>
								<div class="padding-10">
									<div id="statsChart" class="chart-large has-legend-unique"></div>
								</div>

							</div>
							<!-- end s2 tab pane -->

							<div class="tab-pane fade" id="s3">

								<div class="widget-body-toolbar bg-color-white smart-form" id="rev-toggles">

									<div class="inline-group">

										<label for="gra-0" class="checkbox">
											<input type="checkbox" name="gra-0" id="gra-0" checked="checked">
											<i></i> <%=trs.t("პროექტებიდან")%> </label>
										<label for="gra-1" class="checkbox">
											<input type="checkbox" name="gra-1" id="gra-1" checked="checked">
											<i></i> <%=trs.t("კომეციული")%> </label>
										<label for="gra-2" class="checkbox">
											<input type="checkbox" name="gra-2" id="gra-2" checked="checked">
											<i></i> <%=trs.t("სხვა")%> </label>
									</div>

									<div class="btn-group hidden-phone pull-right hidden-xs">
										<a class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown"><i class="fa fa-cog"></i> <%=trs.t("ექსპორტი")%> <span class="caret"> </span> </a>
										<ul class="dropdown-menu pull-right">
											<li>
												<a href="javascript:void(0);"><i class="fa fa-file-pdf-o"></i> PDF</a>
											</li>
											<li>
												<a href="javascript:void(0);"><i class="fa fa-file-excel-o"></i> XLS</a>
											</li>
										</ul>
									</div>

								</div>

								<div class="padding-10">
									<div id="flotcontainer" class="chart-large has-legend-unique"></div>
								</div>
							</div>
							<!-- end s3 tab pane -->
						</div>

						<!-- end content -->
					</div>

				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->

		</article>
	</div>

	<!-- end row -->

	<!-- row -->

	<div class="row">

		<article class="col-sm-12 col-md-12 col-lg-6">

			
			<!-- end widget -->

			<!-- new widget -->
			<div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-deletebutton="false" data-widget-togglebutton="false">

				<!-- widget options:
				usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

				data-widget-colorbutton="false"
				data-widget-editbutton="false"
				data-widget-togglebutton="false"
				data-widget-deletebutton="false"
				data-widget-fullscreenbutton="false"
				data-widget-custombutton="false"
				data-widget-collapsed="true"
				data-widget-sortable="false"

				-->
				<header>
					<span class="widget-icon"> <i class="fa fa-list-alt"></i> </span>
					<h2> <%=trs.t("ჩემი შეტყობინებები")%> </h2>
					
				</header>

				<!-- widget div-->
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">

						<input class="form-control" type="text">

					</div>
					<!-- end widget edit box -->

					<div class="widget-body no-padding">
						<!-- content goes here -->
						<div class="widget-body-toolbar">

							<div id="calendar-buttons">

								<div class="btn-group">
									<a href="javascript:void(0)" class="btn btn-default btn-xs" id="btn-prev"><i class="fa fa-chevron-left"></i></a>
									<a href="javascript:void(0)" class="btn btn-default btn-xs" id="btn-next"><i class="fa fa-chevron-right"></i></a>
								</div>
							</div>
						</div>
						<div id="calendar"></div>

						<!-- end content -->
					</div>

				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->

		</article>

		<article class="col-sm-12 col-md-12 col-lg-6">
			

			<!-- new widget -->
			<div class="jarviswidget jarviswidget-color-blue" id="wid-id-4" data-widget-editbutton="false" data-widget-colorbutton="false" data-widget-togglebutton="false" data-widget-deletebutton="false">

				<!-- widget options:
				usage: <div class="jarviswidget" id="wid-id-0" data-widget-editbutton="false">

				data-widget-colorbutton="false"
				data-widget-editbutton="false"
				data-widget-togglebutton="false"
				data-widget-deletebutton="false"
				data-widget-fullscreenbutton="false"
				data-widget-custombutton="false"
				data-widget-collapsed="true"
				data-widget-sortable="false"

				-->

				<header>
					<span class="widget-icon"> <i class="fa fa-check txt-color-white"></i> </span>
					<h2> <%=trs.t("დასამოწმებელი")%> </h2>
					<!-- <div class="widget-toolbar">
					add: non-hidden - to disable auto hide

					</div>-->
				</header>

				<!-- widget div-->
				<div>
					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<div>
							<label>Title:</label>
							<input type="text" />
						</div>
					</div>
					<!-- end widget edit box -->

					<div class="widget-body no-padding smart-form">
						<!-- content goes here -->
						<h5 class="todo-group-title"><i class="fa fa-warning"></i> <%=trs.t("სასწრაფო")%> (<small class="num-of-tasks">1</small>)</h5>
						<ul id="sortable1" class="todo">
							<li>
								<span class="handle"> <label class="checkbox">
										<input type="checkbox" name="checkbox-inline">
										<i></i> </label> </span>
								<p>
									<strong><%=trs.t("კვლევა")%> #17643</strong> - <%=trs.t("15 დღის წინ")%> [<a href="javascript:void(0);" class="font-xs"><%=trs.t("დამოწმება")%></a>] <span class="text-muted"><%=trs.t("ბაქტერიოლოგიური ლაბორატორია")%> </span>
									<span class="date">02/08/2017</span>
								</p>
							</li>
						</ul>
						<h5 class="todo-group-title"><i class="fa fa-exclamation"></i> <%=trs.t("მნიშვნელოვანი")%> (<small class="num-of-tasks">2</small>)</h5>
						<ul id="sortable2" class="todo">
							<li>
								<span class="handle"> <label class="checkbox">
										<input type="checkbox" name="checkbox-inline">
										<i></i> </label> </span>
								<p>
									<strong><%=trs.t("კვლევა")%> #17644</strong> - <%=trs.t("15 დღის წინ")%> [<a href="javascript:void(0);" class="font-xs"><%=trs.t("დამოწმება")%></a>] <span class="text-muted"><%=trs.t("სეროლოგიური ლაბორატორია")%> </span>
									<span class="date">22/08/2017</span>
								</p>
							</li>
							<li>
								<span class="handle"> <label class="checkbox">
										<input type="checkbox" name="checkbox-inline">
										<i></i> </label> </span>
								<p>
									<strong><%=trs.t("კვლევა")%> #17648</strong> - <%=trs.t("15 დღის წინ")%> [<a href="javascript:void(0);" class="font-xs"><%=trs.t("დამოწმება")%></a>] <span class="text-muted"><%=trs.t("ბაქტერიოლოგიური ლაბორატორია")%> </span>
									<span class="date">22/08/2017</span>
								</p>
							</li>
						</ul>

						

						<!-- end content -->
					</div>

				</div>
				<!-- end widget div -->
			</div>
			<!-- end widget -->

		</article>

	</div>

	<!-- end row -->

</section>
<!-- end widget grid -->

<script type="text/javascript">
	/* DO NOT REMOVE : GLOBAL FUNCTIONS!
	 *
	 * pageSetUp(); WILL CALL THE FOLLOWING FUNCTIONS
	 *
	 * // activate tooltips
	 * $("[rel=tooltip]").tooltip();
	 *
	 * // activate popovers
	 * $("[rel=popover]").popover();
	 *
	 * // activate popovers with hover states
	 * $("[rel=popover-hover]").popover({ trigger: "hover" });
	 *
	 * // activate inline charts
	 * runAllCharts();
	 *
	 * // setup widgets
	 * setup_widgets_desktop();
	 *
	 * // run form elements
	 * runAllForms();
	 *
	 ********************************
	 *
	 * pageSetUp() is needed whenever you load a page.
	 * It initializes and checks for all basic elements of the page
	 * and makes rendering easier.
	 *
	 */

	 var flot_updating_chart, flot_statsChart, flot_multigraph, calendar;

	pageSetUp();
	
	/*
	 * PAGE RELATED SCRIPTS
	 */

	// pagefunction
	
	var pagefunction = function() {
			
		$(".js-status-update a").click(function () {
		    var selText = $(this).text();
		    var $this = $(this);
		    $this.parents('.btn-group').find('.dropdown-toggle').html(selText + ' <span class="caret"></span>');
		    $this.parents('.dropdown-menu').find('li').removeClass('active');
		    $this.parent().addClass('active');
		});
		
		/*
		 * TODO: add a way to add more todo's to list
		 */
		
		// initialize sortable
		
	    $("#sortable1, #sortable2").sortable({
	        handle: '.handle',
	        connectWith: ".todo",
	        update: countTasks
	    }).disableSelection();
		
		
		// check and uncheck
		$('.todo .checkbox > input[type="checkbox"]').click(function () {
		    var $this = $(this).parent().parent().parent();
		
		    if ($(this).prop('checked')) {
		        $this.addClass("complete");
		
		        // remove this if you want to undo a check list once checked
		        //$(this).attr("disabled", true);
		        $(this).parent().hide();
		
		        // once clicked - add class, copy to memory then remove and add to sortable3
		        $this.slideUp(500, function () {
		            $this.clone().prependTo("#sortable3").effect("highlight", {}, 800);
		            $this.remove();
		            countTasks();
		        });
		    } else {
		        // insert undo code here...
		    }
		
		})
		// count tasks
		function countTasks() {
		
		    $('.todo-group-title').each(function () {
		        var $this = $(this);
		        $this.find(".num-of-tasks").text($this.next().find("li").size());
		    });
		
		}
                
                function getTooltip(label, x, y) {
                    return label+" - " + x + ": " + y; 
                }
		
		/*
		 * RUN PAGE GRAPHS
		 */

		// load all flot plugins
		loadScript("js/plugin/flot/jquery.flot.cust.min.js", function(){
			loadScript("js/plugin/flot/jquery.flot.resize.min.js", function(){
				loadScript("js/plugin/flot/jquery.flot.time.min.js", function(){
					loadScript("js/plugin/flot/jquery.flot.tooltip.min.js", generatePageGraphs);
				});
			});
		});

		
		function generatePageGraphs() {
		
		    /* TAB 1: UPDATING CHART */
		    // For the demo we use generated data, but normally it would be coming from the server
		
		    var data = [{
		                label: "<%=trs.t("ტესტის შედეგები")%>",
		                data: [<%=qc[0]%>],
		                lines: {
		                    show: true,
		                    lineWidth: 1,
		                    fill: true,
		                    fillColor: {
		                        colors: [{
		                            opacity: 0.1
		                        }, {
		                            opacity: 0.13
		                        }]
		                    }
		                },
		                points: {
		                    show: true
		                }
		            },{
		                label: "<%=trs.t("სტანდარტული გადახრები +10%")%>",
		                data: [<%=qc[1]%>],
		                lines: {
		                    show: true,
		                    lineWidth: 1,
		                    fill: false
		                },
		                points: {
		                    show: false
		                }
		            },{
		                label: "<%=trs.t("სტანდარტული გადახრები +5%")%>",
		                data: [<%=qc[2]%>],
		                lines: {
		                    show: true,
		                    lineWidth: 1,
		                    fill: false
		                },
		                points: {
		                    show: false
		                }
		            },{
		                label: "<%=trs.t("გადახრა არაა")%>",
		                data: [<%=qc[3]%>],
		                lines: {
		                    show: true,
		                    lineWidth: 1,
		                    fill: false
		                },
		                points: {
		                    show: false
		                }
		            },{
		                label: "<%=trs.t("სტანდარტული გადახრები -5%")%>",
		                data: [<%=qc[4]%>],
		                lines: {
		                    show: true,
		                    lineWidth: 1,
		                    fill: false
		                },
		                points: {
		                    show: false
		                }
		            },{
		                label: "<%=trs.t("სტანდარტული გადახრები -10%")%>",
		                data: [<%=qc[5]%>],
		                lines: {
		                    show: true,
		                    lineWidth: 1,
		                    fill: false
		                },
		                points: {
		                    show: false
		                }
		            }],
		        totalPoints = 200,
		        $UpdatingChartColors = $("#updating-chart").css('color');
		
		    
		
		    
		
		    // setup plot
		    var options = {
                        colors: ["#1E27AB", "#8C3280", "#ED283B", "green", "#ED283B", "#8C3280"],
		        yaxis: {
		            min: -12,
		            max: 12
		        },
		        xaxis: {
		                mode: "time",
                                monthNames: ["<%=trs.t("იან")%>","<%=trs.t("თებ")%>","<%=trs.t("მარ")%>", "<%=trs.t("აპრ")%>", "<%=trs.t("მაი")%>", "<%=trs.t("ივნ")%>", "<%=trs.t("ივლ")%>", "<%=trs.t("აგვ")%>", "<%=trs.t("სექ")%>", "<%=trs.t("ოქტ")%>", "<%=trs.t("ნოე")%>", "<%=trs.t("დეკ")%>"]
		        },
		        series: {
		            lines: {
		                lineWidth: 1,
		                fill: false,
		                steps: false
		
		            }
		        },
                        legend: {
                            show: true,
                            container: $("#legend1"),
                            noColumns: 1,
                            labelFormatter: function(label, series) {
                                // series is the series object for the label
                                return '<div class="font-md" style="color: '+series.color+'"><b>' + label + '</b></div>';
                            }
                        }
		    };
		
		    flot_updating_chart = $.plot($("#updating-chart"), data, options);
		
		    /* live switch */
		    $('input[type="checkbox"]#start_interval').click(function () {
		        if ($(this).prop('checked')) {
		            $on = true;
		            updateInterval = 1500;
		            update();
		        } else {
		            clearInterval(updateInterval);
		            $on = false;
		        }
		    });
		
		    function update() {

				try {
			        if ($on == true) {
			            flot_updating_chart.setData([getRandomData()]);
			            flot_updating_chart.draw();
			            setTimeout(update, updateInterval);
			
			        } else {
			            clearInterval(updateInterval)
			        }
				}
				catch(err) {
				    clearInterval(updateInterval);
				}
		
		    }
		
		    var $on = false;
		
		    /*end updating chart*/
		
		    /* TAB 2: Social Network  */
		
		    $(function () {
		        // jQuery Flot Chart
		        var commercial = [<%=counts[0]%>],
		            programs = [<%=counts[1]%>],
		            data = [{
		                label: "<%=trs.t("კომერციული")%>",
		                data: commercial,
		                lines: {
		                    show: true,
		                    lineWidth: 1,
		                    fill: true,
		                    fillColor: {
		                        colors: [{
		                            opacity: 0.1
		                        }, {
		                            opacity: 0.13
		                        }]
		                    }
		                },
		                points: {
		                    show: true
		                }
		            }, {
		                label: "<%=trs.t("პროგრამები")%>",
		                data: programs,
		                lines: {
		                    show: true,
		                    lineWidth: 1,
		                    fill: true,
		                    fillColor: {
		                        colors: [{
		                            opacity: 0.1
		                        }, {
		                            opacity: 0.13
		                        }]
		                    }
		                },
		                points: {
		                    show: true
		                }
		            }];
		
		        var options = {
		            grid: {
		                hoverable: true
		            },
		            colors: ["#568A89", "#3276B1"],
		            tooltip: true,
		            tooltipOpts: {
		                //content : getTooltip,
		                defaultTheme: false
		            },
                            xaxis: {
		                mode: "time",
                                monthNames: ["<%=trs.t("იან")%>","<%=trs.t("თებ")%>","<%=trs.t("მარ")%>", "<%=trs.t("აპრ")%>", "<%=trs.t("მაი")%>", "<%=trs.t("ივნ")%>", "<%=trs.t("ივლ")%>", "<%=trs.t("აგვ")%>", "<%=trs.t("სექ")%>", "<%=trs.t("ოქტ")%>", "<%=trs.t("ნოე")%>", "<%=trs.t("დეკ")%>"]
		            },
		            yaxes: {
		
		            }
		        };
		
		        flot_statsChart = $.plot($("#statsChart"), data, options);
		    });
		
		    // END TAB 2
		
		    // TAB THREE GRAPH //
		    /* TAB 3: Revenew  */
		
		    $(function () {
		
		        var trgt = [<%=incomes[0]%>],
		            prft = [<%=incomes[1]%>],
		            sgnups = [<%=incomes[2]%>],
		            toggles = $("#rev-toggles"),
		            target = $("#flotcontainer");
		
		        var data = [{
		            label: "<%=trs.t("პროექტებიდან")%>",
		            data: trgt,
		            lines: {
		                show: true,
		                lineWidth: 1
		            }
		        }, {
		            label: "<%=trs.t("კომერციული")%>",
		            data: prft,
		            color: '#3276B1',
		            lines: {
		                show: true,
		                lineWidth: 3
		            },
		            points: {
		                show: true
		            }
		        }, {
		            label: "<%=trs.t("სხვა")%>",
		            data: sgnups,
		            color: '#71843F',
		            lines: {
		                show: true,
		                lineWidth: 1
		            },
		            points: {
		                show: true
		            }
		        }]
		
		        var options = {
		            grid: {
		                hoverable: true
		            },
		            tooltip: true,
		            tooltipOpts: {
		                //content: '%x - %y',
		                //dateFormat: '%b %y',
		                defaultTheme: false
		            },
		            xaxis: {
		                mode: "time",
                                monthNames: ["<%=trs.t("იან")%>","<%=trs.t("თებ")%>","<%=trs.t("მარ")%>", "<%=trs.t("აპრ")%>", "<%=trs.t("მაი")%>", "<%=trs.t("ივნ")%>", "<%=trs.t("ივლ")%>", "<%=trs.t("აგვ")%>", "<%=trs.t("სექ")%>", "<%=trs.t("ოქტ")%>", "<%=trs.t("ნოე")%>", "<%=trs.t("დეკ")%>"]
		            },
		            yaxes: {
		                tickFormatter: function (val, axis) {
		                    return "$" + val;
		                },
		                max: 1200
		            }
		
		        };
		
		        flot_multigraph = null;
		
		        function plotNow() {
		            var d = [];
		            toggles.find(':checkbox').each(function () {
		                if ($(this).is(':checked')) {
		                    d.push(data[$(this).attr("name").substr(4, 1)]);
		                }
		            });
		            if (d.length > 0) {
		                if (flot_multigraph) {
		                    flot_multigraph.setData(d);
		                    flot_multigraph.draw();
		                } else {
		                    flot_multigraph = $.plot(target, d, options);
		                }
		            }
		
		        };
		
		        toggles.find(':checkbox').on('change', function () {
		            plotNow();
		        });

		        plotNow()
		
		    });
		
		}
	
	};
	
	// end pagefunction

	// destroy generated instances 
	// pagedestroy is called automatically before loading a new page
	// only usable in AJAX version!

	var pagedestroy = function(){
		
		

		//destroy flots
		flot_updating_chart.shutdown();  
		flot_updating_chart=null;
		flot_statsChart.shutdown(); 
		flot_statsChart = null;

		flot_multigraph.shutdown(); 
		flot_multigraph = null;

		// destroy vector map objects
		$('#vector-map').find('*').addBack().off().remove();

		// destroy todo
		$("#sortable1, #sortable2").sortable("destroy");
		

		// destroy misc events
		$("#rev-toggles").find(':checkbox').off();



	}

	// end destroy
	
	// run pagefunction on load
	pagefunction();
	
	
</script>
