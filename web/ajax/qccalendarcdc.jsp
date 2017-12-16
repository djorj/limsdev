<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
%>
<div class="col-sm-12 col-md-12 col-lg-9">

		<!-- new widget -->
		<div class="jarviswidget jarviswidget-color-blueDark">

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
				<span class="widget-icon"> <i class="fa fa-calendar"></i> </span>
				<h2> <%=trs.t("ხარისხის კონტროლის გრაფიკი")%> </h2>
				<div class="widget-toolbar">
					<!-- add: non-hidden - to disable auto hide -->
					<div class="btn-group">
						<button class="btn dropdown-toggle btn-xs btn-default" data-toggle="dropdown">
							<%=trs.t("ჩვენება")%> <i class="fa fa-caret-down"></i>
						</button>
						<ul class="dropdown-menu js-status-update pull-right">
							<li>
								<a href="javascript:void(0);" id="mt"><%=trs.t("თვე")%></a>
							</li>
							<li>
								<a href="javascript:void(0);" id="ag"><%=trs.t("კვირა")%></a>
							</li>
							<li>
								<a href="javascript:void(0);" id="td"><%=trs.t("დღეს")%></a>
							</li>
						</ul>
					</div>
				</div>
			</header>

			<!-- widget div-->
			<div>

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

	</div>

</div>

<div class="modal fade" id="qcModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ხარისხის კონტროლის შედეგები - ენტერობაქტერია (Enterobacter sakazakii)")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form col-sm-12">
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("ჩაატარა - გიორგი გიორგაძემ")%></label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("ჩატარების თარიღი და დრო")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input class="datetime" placeholder="" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("ლოგიკური პასუხი")%></label>
                        <label class="toggle">
                            <input name="checkbox-toggle" checked="checked" type="checkbox">
                            <i data-swchon-text="POS" data-swchoff-text="NEG"></i><%=trs.t("დადებითი")%>
                        </label>
                        <label class="toggle">
                            <input name="checkbox-toggle" type="checkbox">
                            <i data-swchon-text="POS" data-swchoff-text="NEG"></i><%=trs.t("უარყოფითი")%>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("ტექსტური პასუხი")%></label>
                        <label class="input">
                            <label class="input"> <i class="icon-append fa fa-list"></i>
                            <input class="" placeholder="" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("რიცხვითი პასუხი")%></label>
                        <label class="input">
                            <label class="input"> <span class="icon-append" style="font-size: 11px; font-weight: bold; text-align: right;">ml/g</span>
                            <input class="numeric right" placeholder="" type="text">
                        </label>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<script src="js/plugin/bootstrap-tags/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
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

	pageSetUp();
	
	/*
	 * ALL PAGE RELATED SCRIPTS CAN GO BELOW HERE
	 * eg alert("my home function");
	 * 
	 * var pagefunction = function() {
	 *   ...
	 * }
	 * loadScript("js/plugin/_PLUGIN_NAME_.js", pagefunction);
	 * 
	 * TO LOAD A SCRIPT:
	 * var pagefunction = function (){ 
	 *  loadScript(".../plugin.js", run_after_loaded);	
	 * }
	 * 
	 * OR
	 * 
	 * loadScript(".../plugin.js", run_after_loaded);
	 */
	
	// PAGE RELATED SCRIPTS

	// pagefunction
	
	var pagefunction = function() {
		
		// full calendar
		
		var date = new Date();
	    var d = date.getDate();
	    var m = date.getMonth();
	    var y = date.getFullYear();
            
            $(".datetime").datetimepicker({
                format: 'DD/MM/YYYY HH:mm'
            });
	
	    var hdr = {
	        left: 'title',
	        center: 'month,agendaWeek,agendaDay',
	        right: 'prev,today,next'
	    };
	
	    var initDrag = function (e) {
	        // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
	        // it doesn't need to have a start or end
	
	        var eventObject = {
	            title: $.trim(e.children().text()), // use the element's text as the event title
	            description: $.trim(e.children('span').attr('data-description')),
	            icon: $.trim(e.children('span').attr('data-icon')),
	            className: $.trim(e.children('span').attr('class')) // use the element's children as the event class
	        };
	        // store the Event Object in the DOM element so we can get to it later
	        e.data('eventObject', eventObject);
	
	        // make the event draggable using jQuery UI
	        e.draggable({
	            zIndex: 999,
	            revert: true, // will cause the event to go back to its
	            revertDuration: 0 //  original position after the drag
	        });
	    };
	
	    var addEvent = function (title, priority, description, icon) {
	        title = title.length === 0 ? "Untitled Event" : title;
	        description = description.length === 0 ? "No Description" : description;
	        icon = icon.length === 0 ? " " : icon;
	        priority = priority.length === 0 ? "label label-default" : priority;
	
	        var html = $('<li><span class="' + priority + '" data-description="' + description + '" data-icon="' +
	            icon + '">' + title + '</span></li>').prependTo('ul#external-events').hide().fadeIn();
	
	        $("#event-container").effect("highlight", 800);
	
	        initDrag(html);
	    };
	
	    /* initialize the external events
		 -----------------------------------------------------------------*/
	
	    $('#external-events > li').each(function () {
	        initDrag($(this));
	    });
	
	    $('#add-event').click(function () {
	        var title = $('#title').val(),
	            priority = $('input:radio[name=priority]:checked').val(),
	            description = $('#description').val(),
	            icon = $('input:radio[name=iconselect]:checked').val();
	
	        addEvent(title, priority, description, icon);
	    });
	
	    /* initialize the calendar
		 -----------------------------------------------------------------*/
	
	    $('#calendar').fullCalendar({
	
	        header: hdr,
	        buttonText: {
	            prev: '<i class="fa fa-chevron-left"></i>',
	            next: '<i class="fa fa-chevron-right"></i>'
	        },
	
	        editable: true,
	        droppable: true, // this allows things to be dropped onto the calendar !!!
	
	        drop: function (date, allDay) { // this function is called when something is dropped
	
	            // retrieve the dropped element's stored Event Object
	            var originalEventObject = $(this).data('eventObject');
	
	            // we need to copy it, so that multiple events don't have a reference to the same object
	            var copiedEventObject = $.extend({}, originalEventObject);
	
	            // assign it the date that was reported
	            copiedEventObject.start = date;
	            copiedEventObject.allDay = allDay;
	
	            // render the event on the calendar
	            // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
	            $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
	
	            // is the "remove after drop" checkbox checked?
	            if ($('#drop-remove').is(':checked')) {
	                // if so, remove the element from the "Draggable Events" list
	                $(this).remove();
	            }
	
	        },
	
	        select: function (start, end, allDay) {
	            var title = prompt('Event Title:');
	            if (title) {
	                calendar.fullCalendar('renderEvent', {
	                        title: title,
	                        start: start,
	                        end: end,
	                        allDay: allDay
	                    }, true // make the event "stick"
	                );
	            }
	            calendar.fullCalendar('unselect');
	        },
	
	        events: [{
                    id: 15,
	            title: 'Siemens ADVIA',
	            start: new Date(y, m, d, 10, 0),
                    end: new Date(y, m, d, 11, 0),
                    allDay: false,
	            description: '<%=trs.t("დადებითი კონტროლი")%>',
	            className: ["event", "bg-color-greenLight"],
	            icon: 'fa-check'
	        }, {
                    id: 16,
	            title: 'Sysmex X4000 - ლაბორატორია',
	            start: new Date(y, m, d+2, 10, 0),
                    end: new Date(y, m, d+2, 11, 0),
                    allDay: false,
	            description: '<%=trs.t("კალიბრაცია")%>',
	            className: ["event", "bg-color-blue"],
	            icon: 'fa-check'
	        }/*, {
	            id: 999,
	            title: 'Repeating Event',
	            start: new Date(y, m, d - 3, 16, 0),
	            allDay: false,
	            className: ["event", "bg-color-blue"],
	            icon: 'fa-clock-o'
	        }, {
	            id: 999,
	            title: 'Repeating Event',
	            start: new Date(y, m, d + 4, 16, 0),
	            allDay: false,
	            className: ["event", "bg-color-blue"],
	            icon: 'fa-clock-o'
	        }, {
	            title: 'Meeting',
	            start: new Date(y, m, d, 10, 30),
	            allDay: false,
	            className: ["event", "bg-color-darken"]
	        }, {
	            title: 'Lunch',
	            start: new Date(y, m, d, 12, 0),
	            end: new Date(y, m, d, 14, 0),
	            allDay: false,
	            className: ["event", "bg-color-darken"]
	        }, {
	            title: 'Birthday Party',
	            start: new Date(y, m, d + 1, 19, 0),
	            end: new Date(y, m, d + 1, 22, 30),
	            allDay: false,
	            className: ["event", "bg-color-darken"]
	        }, {
	            title: 'Smartadmin Open Day',
	            start: new Date(y, m, 28),
	            end: new Date(y, m, 29),
	            className: ["event", "bg-color-darken"]
	        }*/
                ],
                
                eventClick: function(calEvent, jsEvent, view) {
                    if(calEvent.id == 15)
                        $('#qcModal').modal('show');
                    else
                        alert("კალიბრაციის შედეგების ფანჯარა");

                    // change the border color just for fun
                    $(this).css('border-color', 'red');

                },
	        eventRender: function (event, element, icon) {
	            if (!event.description == "") {
	                element.find('.fc-event-title').append("<br/><span class='ultra-light'>" + event.description +
	                    "</span>");
	            }
	            if (!event.icon == "") {
	                element.find('.fc-event-title').append("<i class='air air-top-right fa " + event.icon +
	                    " '></i>");
	            }
	        },
	
	        windowResize: function (event, ui) {
	            $('#calendar').fullCalendar('render');
	        }
	    });
	
	    /* hide default buttons */
	    $('.fc-header-right, .fc-header-center').hide();

	
	
		$('#calendar-buttons #btn-prev').click(function () {
		    $('.fc-button-prev').click();
		    return false;
		});
		
		$('#calendar-buttons #btn-next').click(function () {
		    $('.fc-button-next').click();
		    return false;
		});
		
		$('#calendar-buttons #btn-today').click(function () {
		    $('.fc-button-today').click();
		    return false;
		});
		
		$('#mt').click(function () {
		    $('#calendar').fullCalendar('changeView', 'month');
		});
		
		$('#ag').click(function () {
		    $('#calendar').fullCalendar('changeView', 'agendaWeek');
		});
		
		$('#td').click(function () {
		    $('#calendar').fullCalendar('changeView', 'agendaDay');
		});
		
	};
	
	// end pagefunction
	
	// loadscript and run pagefunction
	loadScript("js/plugin/fullcalendar/jquery.fullcalendar.min.js", pagefunction);


</script>