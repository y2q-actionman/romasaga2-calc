function invokeChangeEvent(targetElem) {
    targetElem.dispatchEvent(new Event("change"));
}

function changeAndInvokeChangeEvent(targetElem, newValue) {
    if (targetElem.value != newValue) {
       	targetElem.value = newValue;
	invokeChangeEvent(targetElem);
    }
}

function invokeAllCharacterChangeEvent() {
    for(i of document.querySelectorAll('.character')){
	invokeChangeEvent(i);
    }
}

function makeDojoWazaList() {
    let ret = [];
    for (i of document.querySelectorAll('#dojo input:checked')) {
	ret.push(i.name);
    }
    return ret;
}

function makeEquipWazaList(equipWazaElem) {
    let ret = [];
    for (i of equipWazaElem.querySelectorAll('input')) {
	if(i.value) ret.push(i.value);
    }
    return ret;
}

// Building 'equipWaza' by initial waza list.
function updateEquipWaza(equipWazaElem, characterName) {
    const wazaList = findCharacter初期技List(characterName, makeDojoWazaList());
    const inputs = equipWazaElem.querySelectorAll('input');
    for (let i = 0; i < inputs.length; ++i) {
	inputs[i].value = (i < wazaList.length) ? wazaList[i] : null;
    }
}

// Building 'hiramekiTable'.
function buildTBodyCaption(name, colspan) {
    let tr = document.createElement('tr');
    let th = tr.appendChild(document.createElement('th'));
    th.setAttribute("colspan", colspan)
    th.appendChild(document.createTextNode(name));
    return tr;
}

const PROB_FORMATTER = new Intl.NumberFormat(undefined, { style: "percent", maximumFractionDigits: 2, minimumFractionDigits: 2, mimimumIntegerDigits: 1 });

const HIRAMEKI_TABLE_HEADER = ['技名', '確率', '派生元', '技Lv', '固有武器'];

function buildWazaTR(array, isHeader, equipWazaList, dojoWazaList) {
    const tr = document.createElement('tr');

    // <tr> class
    if (!isHeader) {
	const 派生元 = array[2];
	if (equipWazaList.includes(派生元)) {
	    tr.classList.add("equipped");
	} else if (!閃き済み技LIST.includes(派生元) && !dojoWazaList.includes(派生元)) {
	    tr.classList.add("notInDojo");
	}
    }

    // <td> class
    for (i of array) {
	let td = tr.appendChild(document.createElement(isHeader ? 'th' : 'td'));
	if (i) {
	    if(Number.isFinite(i)) {
		td.classList.add("numeric");
		if(!Number.isInteger(i)) {
		    i = PROB_FORMATTER.format(i);
		}
	    }
	    td.appendChild(document.createTextNode(i));
	}
    }
    return tr;
}

function updateHiramekiTable(characterDivElem) {
    const eLevel = document.querySelector('#enemyTechLevel').value;
    if(!eLevel) return;

    const hiramekiId = characterDivElem.querySelector('.hiramekiTypeId').value;
    if(!hiramekiId) return;

    const availableWaza = find閃き可能WazaListBy閃きTypeId(hiramekiId);

    const wazaTypeList = [];
    for (i of characterDivElem.querySelectorAll('.wazaFilter input.wazaType:checked')) {
	wazaTypeList.push(i.name);
    }

    const includeUnique = (characterDivElem.querySelector('.wazaFilter input.unique:checked')) ? true : false;

    // Building table.
    const table = document.createElement('table');

    // Body
    const equipWazaList = makeEquipWazaList(characterDivElem.querySelector(".equipWaza"));
    const dojoWazaList = makeDojoWazaList();
    for (wKind of wazaTypeList) {
	let hiramekiList = calcWazaHiramekiList(find技種類技一覧Alist(wKind),
	  					閃き済み技LIST.concat(equipWazaList).concat(dojoWazaList),
	  					eLevel,
	  					availableWaza,
						includeUnique);
	if (!hiramekiList || hiramekiList.length <= 0)
	    continue;

	let tbody = table.appendChild(document.createElement('tbody'));

	let tbodyCap = tbody.appendChild(buildTBodyCaption(wKind, HIRAMEKI_TABLE_HEADER.length));
	tbodyCap.classList.add("tbodyCaption");

	let tbodyHeader = tbody.appendChild(buildWazaTR(HIRAMEKI_TABLE_HEADER, true));
	tbodyHeader.classList.add("tbodyHeader");

	for (i of hiramekiList) {
	    tbody.appendChild(buildWazaTR(i, false, equipWazaList, dojoWazaList));
	}
    }

    const outputTable = characterDivElem.querySelector('.hiramekiTableOutput table');
    outputTable.replaceWith(table);
}
