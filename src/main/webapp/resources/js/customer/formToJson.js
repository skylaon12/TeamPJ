// form 안에 있는 모든 input의 name과 value를 객체 형태로 변환한다.
function formToJson(form) {
	let values = {};
	let inputs = form.find("input");
	
	inputs.each(function(index, element) {
		values[element.name] = element.value;
	});
	return values;
}