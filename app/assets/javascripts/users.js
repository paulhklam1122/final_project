$("ul.nav-tabs a").click(function (e) {
  e.preventDefault();
    $(this).tab('show');
});
$("ul.nav-pills a").click(function (e) {
  e.preventDefault();
    $(this).tab('show');
});


$(function() {
  return $('.infinite-table').infinitePages({
    loading: function() {
      return $(this).text('');
    },
    error: function() {
      return $(this).button('');
    }
  });
});


$(document).ready(function(){
  $('#pie-chart').hide().show();
  $('#bar-graph').hide().show();
})

// ===================================MORTGAGE CALCULATOR============================================

function validNumber(fieldinput){
  var unicode=fieldinput.charCode? fieldinput.charCode : fieldinput.keyCode;
  if ((unicode!=8) && (unicode!=46)) { //if the key isn't the backspace key (which we should allow)
    if (unicode<48||unicode>57) //if not a number
    return false; //disable key press
  }
}

function myPayment() {

  // Reset error messages to blank
  $('#loanError').html('');
  $('#yearsError').html('');
  $('#rateError').html('');
  $('#friendlyReminder').css({ 'display': "none" });
  $('#unfriendlyReminder').css({ 'display': "none" });


  // Form validation checking
  if (($("form[name='mortgagecalc'] input[name='value']").val() === null) || ($("form[name='mortgagecalc'] input[name='value']").val().length === 0) || (isNaN($("form[name='mortgagecalc'] input[name='value']").val()) === true)) {
    $('#monthlyPayment').html('Please complete the form.');
    $('#propertyError').html('Please enter a property value amount. Example: 555000');
  } else if (($("form[name='mortgagecalc'] input[name='loan']").val() === null) || ($("form[name='mortgagecalc'] input[name='loan']").val().length === 0) || (isNaN($("form[name='mortgagecalc'] input[name='loan']").val()) === true)) {
    $('#monthlyPayment').html('Please complete the form.');
    $('#loanError').html('Please enter a mortgage amount. Example: 325000');
  } else if (($("form[name='mortgagecalc'] input[name='years']").val() === null) || ($("form[name='mortgagecalc'] input[name='years']").val().length === 0) || (isNaN($("form[name='mortgagecalc'] input[name='years']").val()) === true)) {
    $('#monthlyPayment').html('Please complete the form..');
    $('#yearsError').html('Please enter the number of years for the mortgage. Example: 30');
  } else if (($("form[name='mortgagecalc'] input[name='rate']").val() === null) || ($("form[name='mortgagecalc'] input[name='rate']").val().length === 0) || (isNaN($("form[name='mortgagecalc'] input[name='rate']").val()) === true)) {
    $('#monthlyPayment').html('Please complete the form.');
    $('#rateError').html('Please enter a valid interest rate. Example: 6.43');
  }
  else if (($("form[name='mortgagecalc'] input[name='value']").val()) < ($("form[name='mortgagecalc'] input[name='loan']").val())) {
    $('#propertyError').html('The property value has to be larger than the borrowing amount.');}
    else {
    // Set variables from form data
    var propertyValue = $("form[name='mortgagecalc'] input[name='value']").val();
    var loanPrincipal = $("form[name='mortgagecalc'] input[name='loan']").val();
    var months = $("form[name='mortgagecalc'] input[name='years']").val() * 12;
    var interest = $("form[name='mortgagecalc'] input[name='rate']").val() / 1200;

    var payment = loanPrincipal * interest / (1 - (Math.pow(1/(1 + interest), months)));
    var monthlyPropertyTax = propertyValue * 0.005 / 12
    var monthlyPropertyUtilities = 50
    var monthlyIncome = parseFloat($('#monthlyIncome').html());
    var newMonthlyIncome = monthlyIncome - monthlyPropertyTax - monthlyPropertyUtilities
    var monthlyMortgagePayments = parseFloat($('#monthlyMortgagePayments').html());
    var monthlyLoanPayments = parseFloat($('#monthlyLoanPayments').html());
    var newTotalMortgagePayments = payment + monthlyMortgagePayments;
    var newTotalLoanPayments = payment + monthlyLoanPayments;
    var amountMissing = (newTotalMortgagePayments / 0.3249) - newMonthlyIncome;
    var downpaymentPercentage = (propertyValue - loanPrincipal) / propertyValue;
    var GDSR = 0.3249;
    var TDSR = 0.4149;

    // calculate mortgage affordability and generate result
    if ((((newTotalMortgagePayments / newMonthlyIncome).toFixed(4)) < GDSR) && (((newTotalLoanPayments / newMonthlyIncome).toFixed(4)) / TDSR)) {
      var goodResult = "Congratulations! You should be able to afford this mortgage!";
      if (downpaymentPercentage >= 0.2) {
        $('#friendlyReminder').css({ 'display': "block" });
      } else if (downpaymentPercentage < 0.05) {
        var badResult = "Unfortunately, the province of BC requires a minimum downpayment percentage of 5%.";
      } else {
        $('#unfriendlyReminder').css({ 'display': "block" });
      }
    } else {
      var badResult = "Unfortunately, your income is insufficient. You need $" + (amountMissing).toFixed(2) + "per month. ($" + (amountMissing * 12).toFixed(2) + "per year)";
    }


  // Calculate mortgage payment and display result
  $('#goodComparison').html('').css({ 'display': "none" })
  $('#badComparison').html('').css({ 'display': "none" })
  $('#monthlyPayment').html('Your monthly mortgage payment would be ' + '$' + payment.toFixed(2) + '. Your new total mortgage monthly payment amount will be ' + '$' + newTotalMortgagePayments.toFixed(2));
  $('#goodComparison').css({ 'display': "block" }).html(goodResult)
  $('#badComparison').css({ 'display': "block" }).html(badResult)
  }


// payment = principle * monthly interest/(1 - (1/(1+MonthlyInterest)*Months))
}

function myPaymentReset() {
  // Reset everything to default/null/blank
  $('#monthlyPayment').html('Values reset');
  $('#goodComparison').html('').css({ 'display': "none" })
  $('#badComparison').html('').css({ 'display': "none" })
  $('#friendlyReminder').css({ 'display': "none" });
  $('#unfriendlyReminder').css({ 'display': "none" });
  $('#propertyError').html('');
  $('#loanError').html('');
  $('#yearsError').html('');
  $('#rateError').html('');
  $("form[name='mortgagecalc'] input[name='value']").val('');
  $("form[name='mortgagecalc'] input[name='loan']").val('');
  $("form[name='mortgagecalc'] input[name='years']").val('');
  $("form[name='mortgagecalc'] input[name='rate']").val('');
}

// ===================================RETIREMENT CALCULATOR============================================

function jumpBox(list) {
  location.href = list.options[list.selectedIndex].value
}
function formatNum(Vnum) {

  if(Vnum > 99000000) {
    alert("Sorry, this will not generate numbers larger that 99 million.");
    focus();
  } else {

    var V10million = parseInt(Vnum / 10000000);

    var V1million = (Vnum % 10000000)  / 1000000;
    if(V1million / 1000000 == 1) {
      V1million = 1;
    } else
    if(V1million < 1) {
      V1million = "0";
    } else {
      V1million = parseInt(V1million,10);
    }

    var V100thousand = (Vnum % 1000000)  / 100000;
    if(V100thousand / 100000 == 1) {
      V100thousand = 1;
    } else
    if(V100thousand < 1) {
      V100thousand = "0";
    } else {
      V100thousand = parseInt(V100thousand,10);
    }

    var V10thousand = (Vnum % 100000)  / 10000;
    if(V10thousand / 10000 == 1) {
      V10thousand = 1;
    } else
    if(V10thousand < 1) {
      V10thousand = "0";
    } else {
      V10thousand = parseInt(V10thousand,10);
    }

    var V1thousand = (Vnum % 10000)  / 1000;
    if(V1thousand / 1000 == 1) {
      V1thousand = 1;
    } else
    if(V1thousand < 1) {
      V1thousand = "0";
    } else {
      V1thousand = parseInt(V1thousand,10);
    }

    var Vhundreds = (Vnum % 1000)  / 100;
    if(Vhundreds / 100 == 1) {
      Vhundreds = 1;
    } else
    if(Vhundreds < 1) {
      Vhundreds = "0";
    } else {
      Vhundreds = parseInt(Vhundreds,10);
    }

    var Vtens = (Vnum % 100)  / 10;
    if(Vtens / 10 == 1) {
      Vtens = 1;
    } else
    if(Vtens < 1) {
      Vtens = "0";
    } else {
      Vtens = parseInt(Vtens,10);
    }

    var Vones = (Vnum % 10)  / 1;
    if(Vones / 1 == 1) {
      Vones = 1;
    } else
    if(Vones < 1) {
      Vones = "0";
    } else {
      Vones = parseInt(Vones,10);
    }

    var Vcents = 0;

    if(Vnum % 1 * 100 < 1) {
      Vcents = 0;
    } else {
      Vcents = parseInt(((eval(Vnum % 1) * 100)),10);
    }
    //END UPGRADE

    if(Vcents < 1) {
      Vcents = "00";
    }
    else
    if(Vcents % 10 == 0) {
      Vcents = Vcents + "0";
    }
    else
    if(Vcents % 10 == Vcents) {
      Vcents = "0" + Vcents;
    } else {
      Vcents = Vcents;
    }

    if(Vcents == "900") {
      Vcents = "90";
    } else
    if(Vcents == "800") {
      Vcents = "80";
    } else
    if(Vcents == "700") {
      Vcents = "70";
    } else
    if(Vcents == "600") {
      Vcents = "60";
    } else
    if(Vcents == "500") {
      Vcents = "50";
    } else
    if(Vcents == "400") {
      Vcents = "40";
    } else
    if(Vcents == "300") {
      Vcents = "30";
    } else
    if(Vcents == "200") {
      Vcents = "20";
    } else
    if(Vcents == "100") {
      Vcents = "10";
    } else {
      Vcents = Vcents;
    }
    var Vformat = "";

    if(Vnum >= 10000000) {
      Vformat = (V10million + "" + V1million + "," + V100thousand + "" + V10thousand + "" + V1thousand + "," + Vhundreds + "" + Vtens + "" + Vones + "." + Vcents);
    }
    else
    if(Vnum >= 1000000) {
      Vformat = (V1million + "," + V100thousand + "" + V10thousand + "" + V1thousand + "," + Vhundreds + "" + Vtens + "" + Vones + "." + Vcents);
    }
    else
    if(Vnum >= 100000) {
      Vformat = (V100thousand + "" + V10thousand + "" + V1thousand + "," + Vhundreds + "" + Vtens + "" + Vones + "." + Vcents);
    }
    else
    if(Vnum >= 10000) {
      Vformat = (V10thousand + "" + V1thousand + "," + Vhundreds + "" + Vtens + "" + Vones + "." + Vcents);
    }
    else
    if(Vnum >= 1000) {
      Vformat = (V1thousand + "," + Vhundreds + "" + Vtens + "" + Vones + "." + Vcents);
    }
    else
    if(Vnum >= 100) {
      Vformat = (Vhundreds + "" + Vtens + "" + Vones + "." + Vcents);
    }
    else
    if(Vnum >= 10) {
      Vformat = (Vtens + "" + Vones + "." + Vcents);
    }
    else
    if(Vnum >= 1) {
      Vformat = (Vones + "." + Vcents);
    } else {
      Vformat = ("0." + Vcents);
    }

    return Vformat;


  }
}
function checkNumber(input, min, max, msg)

{

  msg = msg + " field has invalid data: " + input.value;



  var str = input.value;

  for (var i = 0; i < str.length; i++) {

    var ch = str.substring(i, i + 1)

    if ((ch < "0" || "9" < ch) && ch != '.') {

      alert(msg);

      return false;

    }

  }

  var num = 0 + str

  if (num < min || max < num) {

    alert(msg + " not in range [" + min + ".." + max + "]");

    return false;

  }

  input.value = str;

  return true;

}



function computeField(input)

{

  if (input.value != null && input.value.length != 0)

  input.value = "" + eval(input.value);

  computeForm(input.form);

}



function computeForm(form)

{

  if ((form.payments.value == null || form.payments.value.length == 0) ||

  (form.interest.value == null || form.interest.value.length == 0) ||

  (form.principal.value == null || form.principal.value.length == 0)) {

    return;

  }



  if (!checkNumber(form.payments, 1, 480, "# of payments") ||

  !checkNumber(form.interest, .001, 99, "Interest") ||

  !checkNumber(form.principal, 1, 10000000, "Principal")) {

    form.pv.value = "Invalid";

    return;

  }



  var i = form.interest.value;

  if (i > 1.0) {

    i = i / 100.0;
  } else {
    i = i;
  }

  form.interest.value = i;

  i = i /12





  var prin = form.principal.value;

  var nPer = form.payments.value * 12;

  var count = 0;

  var factor = eval(1) + eval(i);

  var denom = 1;

  while(count < nPer) {
    denom = denom * factor;
    count = eval(count) + eval(1);
  }

  var Vpv = eval(1) - eval(1 / denom);

  Vpv = Vpv / i;

  Vpv = prin * Vpv;

  $('#pv').html('$ ' + formatNum(Vpv));


}



function clearForm(form)

{

  form.payments.value = "";

  form.interest.value = "";

  form.principal.value = "";
  $('#pv').html('')

}
