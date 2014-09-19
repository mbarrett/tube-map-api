window.OTTUBEMAP = window.OTTUBEMAP || {};

window.OTTUBEMAP.Availability = function () {
	"use strict";

	var hiddenSecurityIdField = null;
	var hiddenDateTimeField = null;
	var timeSlotClass = null;
	var formId = null;

	var setTimeSlotClickEvents = function () {
		$(".js-timeslot").each(function () {
            $(this).click(function (event) {
                event.preventDefault();

                setSelectedSecurityId($(this).attr("data-securityid"));
                setSelectedDateTime($(this).attr("data-datetime"));
                submitForm();
            });
        });
	};

	var setSelectedSecurityId = function (value) {
		var securityIdField = "#" + hiddenSecurityIdField;
		$(securityIdField).val(value);
	};

	var setSelectedDateTime = function (value) {
		var dateTimeField = "#" + hiddenDateTimeField;
		$(dateTimeField).val(value);
	};

	var submitForm = function () {
		var form = "#" + formId;
		$(form).submit();
	};

	return {
		init: function (args) {
			args = args || {};

			hiddenSecurityIdField = args.HiddenSecurityIdField || 'securityid';
			hiddenDateTimeField = args.HiddenDateTimeField || 'datetime';
			timeSlotClass = args.TimeSlotClass || 'js-timeslot';
			formId = args.FormId || 'js-form';

			jQuery(document).ready(function () {
				setTimeSlotClickEvents();
			});
		}
	};
} ();