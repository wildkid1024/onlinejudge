// by bLue
// https://dreamer.blue

cid4AprilFools = [2100, 2481, 2482];

maxPendingRequestNum = 3;
refreshItv = 2;
resultCode = {
	WT: 0,
	AC: 1,
	TLE: 2,
	MLE: 3,
	WA: 4,
	RTE: 5,
	OLE: 6,
	CE: 7,
	PE: 8,
	SE: 11,
	JG: 12
};
resultMap = {
	0: '<td class="bold info-text result-pending">Waiting<img class="status-loader" src="' + statusLoaderUrl + '"></td>',
	1: '<td class="bold accept-text">Accepted</td>',
	2: '<td class="bold tmle-text">Time Limit Exceeded</td>',
	3: '<td class="bold tmle-text">Memory Limit Exceeded</td>',
	4: '<td class="bold wrong-text">Wrong Answer</td>',
	5: '<td class="bold error-text">Runtime Error</td>',
	6: '<td class="bold info-text">Output Limit Exceeded</td>',
	7: '<td class="bold ce-text">Compile Error</td>',
	8: '<td class="bold pe-text">Presentation Error</td>',
	11: '<td class="bold error-text">System Error</td>',
	12: '<td class="bold info-text result-pending">Judging<img class="status-loader" src="' + statusLoaderUrl + '"></td>'
};
resultMap4AprilFools = {
	0: '<td class="bold info-text result-pending">Waiting<img class="status-loader" src="' + statusLoaderUrl + '"></td>',
	1: '<td class="bold wrong-text">Wrong Answer</td>',
	2: '<td class="bold accept-text">Time Limit Accepted</td>',
	3: '<td class="bold accept-text">Memory Limit Accepted</td>',
	4: '<td class="bold accept-text">Accepted</td>',
	5: '<td class="bold accept-text">Runtime Accepted</td>',
	6: '<td class="bold accept-text">Output Limit Accepted</td>',
	7: '<td class="bold accept-text">Compilation Accepted</td>',
	8: '<td class="bold accept-text">Presentation Accepted</td>',
	11: '<td class="bold accept-text">Submission Accepted</td>',
	12: '<td class="bold info-text result-pending">Judging<img class="status-loader" src="' + statusLoaderUrl + '"></td>'
};
resultMapR = {
	'Waiting': 0,
	'Accepted': 1,
	'Time Limit Exceeded': 2,
	'Memory Limit Exceeded': 3,
	'Wrong Answer': 4,
	'Runtime Error': 5,
	'Output Limit Exceeded': 6,
	'Compile Error': 7,
	'Presentation Error': 8,
	'System Error': 11,
	'Judging': 12
};
pendingResultClass = 'result-pending';
resultShowDetailClass = 'result-show-detail';
timeUnit = 'ms';
memoryUnit = 'KiB';

function refreshPendingStatus() {
	// get pending list
	pendingList = [];
	statusSet = {};
	$("#status-table tbody tr").each(function () {
		if($(this).find("." + pendingResultClass).length == 1) {
			var runid = parseInt($(this).find("td").eq(0).text());
			pendingList.push(runid);
			statusSet[runid] = $(this);
		}
	});
	// request new status
	for(var i = pendingList.length - 1; i >= Math.max(pendingList.length - maxPendingRequestNum, 0); --i) {
		// console.log(pendingList[i]);
		$.ajax({
			url: statusApiUrl,
			dataType: "json",
			data: {runid: pendingList[i]},
			cache: false,
			success: function (data) {
				var runid = data[0]["runid"];
				var uid = data[0]["uid"];
				var result = data[0]["result"];
				var time = data[0]["time"] === -1 ? '-- --' : data[0]["time"] + ' ' + timeUnit;
				var memory = data[0]["memory"] === -1 ? '-- --' : data[0]["memory"] + ' ' + memoryUnit;
				var tr = statusSet[runid];
				if(result != tr.find("td").eq(3).data("result")) { // new result
					var resultTd = tr.find("td").eq(3);
					var timeTd = tr.find("td").eq(4);
					var memoryTd = tr.find("td").eq(5);
					// set result
					resultTd.remove();
					timeTd.before(resultMap[result]);
					resultTd = tr.find("td").eq(3);
					if(result === resultCode['CE'] && (hasPerm || sessionUid === uid)) { // add link for Compile Error
						var res = resultTd.text();
						resultTd.html('<a href="' + ceUrl + runid + '">' + res + '</a>');
					}
					resultTd.attr("data-result", result);
					if(result === resultCode['WT'] || result === resultCode['JG'])
						resultTd.addClass(pendingResultClass);
					else if(result !== resultCode['CE']) {
						if(tr.data("spj") == 1) {
							resultTd.addClass(resultShowDetailClass);
							resultTd.click(function () {
								resultShowDetail($(this));
							});
						}
					}
					// set time & memory
					timeTd.text(time);
					memoryTd.text(memory);
				}
			}
		});
	}
	// set timer
	if(pendingList.length >= 0) {
		$("#status-table").oneTime(refreshItv + 's', function () {
			refreshPendingStatus();
		});
	}
}

function resultShowDetail(obj) {
	var runid = obj.closest("tr").find("td").eq(0).text();
	$.ajax({
		url: statusSpjApiUrl,
		dataType: "json",
		data: {
			'runid': runid
		},
		cache: false,
		success: function (data) {
			var tb = $("#result-show-detail-table tbody");
			tb.html('');
			$("#result-show-detail-modal-label span").text('of RunID ' + runid);
			if(data['status'] == 'ok') {
				for(var i=0; i<data['data']['tests'].length; ++i) {
					var test = data['data']['tests'][i];
					tb.append('<tr></tr>');
					var tr = tb.find("tr:last");
					tr.append('<td>#' + (i+1) + '</td>');
					tr.append(resultMap[resultMapR[test['result']]]);
					tr.append('<td>' + test['time_used'] + ' ms</td>');
					tr.append('<td>' + test['memory_used'] + ' KiB</td>');
					tr.append('<td></td>');
					tr.find("td:last").text(test['message']);
				}
			}
		}
	});
	$("#result-show-detail-modal").modal();
}

$(function () {
	$("#status-table tbody tr").each(function () {
		var uid = $(this).find("input[name='hid_uid']").val();
		var resultTd = $(this).find("td").eq(3);
		if($(this).data("spj") == 1 && !resultTd.hasClass(pendingResultClass)
			&& resultTd.find("a").length === 0 && resultTd.text() != 'Compile Error') {
			$(this).find("td").eq(3).addClass(resultShowDetailClass);
		}
	});
	$("#status-table").oneTime(refreshItv + 's', function () {
		refreshPendingStatus();
	});

	$("." + resultShowDetailClass).click(function () {
		resultShowDetail($(this));
	});

	// April Fools
	if(typeof cid !== 'undefined' && $.inArray(cid, cid4AprilFools)>=0) {
		resultMap = resultMap4AprilFools;
	}
});
