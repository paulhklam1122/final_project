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
  } else if (($("form[name='mortgagecalc'] input[name='value']").val()) < ($("form[name='mortgagecalc'] input[name='loan']").val())) {
    $('#propertyError').html('The property value has to be larger than the borrowing amount.');
  } else {
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
