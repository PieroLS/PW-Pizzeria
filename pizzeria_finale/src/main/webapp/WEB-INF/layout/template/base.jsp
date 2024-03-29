<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="it" class="h-100">
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="title"/></title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet" >
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.css" rel="stylesheet" >
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">

<link href="${pageContext.request.contextPath}/static/css/bootstrap.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet" />

<link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet"  />
<script src="${pageContext.request.contextPath}/static/js/bootstrap.bundle.min.js"></script>

<script>

//impostare file con tutti gli script

$(document).ready(function(){

      $("#panel1").slideToggle("slow");
     
});


$(document).ready(function(){
                      $("#trigger1").on('click', function(){
                          $("#info1 ").slideToggle();
                      });
                      $("#trigger2").on('click', function(){
                          $("#info2 ").slideToggle();
                      });
                      $("#trigger3").on('click', function(){
                          $("#info3 ").slideToggle();
                      });
                  });

let actImm = 0;
let limite = 4;





function cambia() {
  if (actImm === limite)
      actImm = 0;
 
  document.getElementById('logo').src="/pizzeria/static/images/"
  document.getElementById('logo').src+=++actImm+".png"
  setTimeout('cambia()', 1000)
}

//si poteva omettere (document).ready (che in JS corrisponderebbe al body.onload) in quanto
//il codice è posto al termine della pagina e non verrà eseguito prima del caricamento della page


      

      function zero(numero) {
          if (numero < 10) {
              numero = "0" + numero; //concateno uno zero davanti al numero: compongo un numero nuovo a due cifre
          }
          return numero;
      }
      let data = new Date(); //istanza di un oggetto di tipo Date();
      let ore = zero(data.getHours());
      let minuti = zero(data.getMinutes());
      let anno = zero(data.getFullYear());
      let messe = zero(data.getMonth() + 1);
      let giorno = zero(data.getDate());
      let dataoggi1 = anno + "-" + messe + "-" + giorno;
      let dataoggi2 = anno + " , " + messe + " , " + giorno;

      let res = new Date(dataoggi2);
      res.setDate(res.getDate() + 10); // Aggiungere giorni
      let giornoMax = zero(res.getDate().toString());
      let messeMax = zero((res.getMonth() + 1).toString());
      let annoMax = res.getFullYear().toString();
      let datamassima = annoMax + "-" + messeMax + "-" + giornoMax;

      let orari = ["11.00","11.30", "12.00", "12.30", "13.00", "13.30", "14.00", "14.30", "15.00", "15.30", "16.00", "16.30", "17.00", "17.30", "18.00", "18.30", "19.00", "19.30", "20.00", "20.30", "21.00", "21.30", "22.00"];
      let i = 0;

      let stringaOrario = parseFloat(ore + "." + minuti);
      let stringaOrario2 = 6.00;

      function modStringaOrario() {
    	
          stringaOrario = 11.00;
          document.getElementById("avviso").style.display = "none";
          document.getElementById("destra").style.display = "block";
          
              // se l'orario in cui un utente sta effettuando la prenotazione rientra negli orari di apertura può procedere con la prenotazione
              document.getElementById("avviso").style.display = "none";
              document.getElementById("destra").style.backgroundColor = "#f2e7c3";
              document.getElementById("titoloFormSeleziona").innerHTML += '<h5>Seleziona giorno e orario in cui desideri effettuare la prenotazione:</h5>';
              $( function() {
                  $( "#datepicker" ).datepicker({ minDate: 0, maxDate: "+0M +10D" }); // se un utente sta effettuando la prenotazione nel giorno stesso la data minima disponibile deve essere il giorno attuale
              } );
              document.getElementById("divGiorno").innerHTML += '<input type="text" id="datepicker" placeholder="Seleziona il giorno in cui prenotare">';
              //document.getElementById("divGiorno").innerHTML += '<input type="date" name="dataCalendar" value="' + dataoggi1 +'" id="dataCalendar2" min="' + dataoggi1 + '" max="' + datamassima +'"/>';
              document.getElementById("divOrario").innerHTML +='<select name="select_orario" class="form-select" id="orarid">';
              document.getElementById("orarid").innerHTML += '<option value="" disabled selected>Seleziona il tuo orario</option>';
              for(i; i < orari.length; i++) {
                  if(stringaOrario < parseFloat(orari[i])) { //controllo su ore successive a quella attuale
                      if (i !== orari.length-1) {
                          let orario_invio = orari[i] + '-' + orari[i+1];
                          //let ora_invio = orari[i];
                          document.getElementById("orarid").innerHTML += '<option value="' + orario_invio + '">' + orario_invio + '</option>';
                      }
                  }
              }
              document.getElementById("divOrario").innerHTML += '</select>';
              document.getElementById("orarid").addEventListener("change", stampa_orario);

          
      }
      function calcoloOre() {
          let oreMancanti = (11 - ore);
          let minutiMancanti = (60 - minuti);
          if (minutiMancanti === 60){
              minutiMancanti = 0;
          }
          document.getElementById("avviso").innerHTML += oreMancanti + " ore e " + minutiMancanti + " minuti.<br/>";
      }
	  	
      function recuperaData() {
          document.getElementById("pulsante").style.display = "none";
          document.getElementById("destra").style.display = "block";
          if (stringaOrario > 22.00) {
              document.getElementById("destra").style.backgroundColor = "#f2e7c3";
              document.getElementById("destra").innerHTML += '<div class="alert alert-danger" id="avviso" style="padding: 10px; text-align: center;">' +
                  'Il ristorante ha chiuso alle 22.00, vuoi effettuare la tua prenotazione un altro giorno?' +
                  '<div class="row" id="siOno"><div class="col-6"><a href="/pizzeria/carrello" class="btn" role="button">NO</a></div> ' +
                  '<div class="col-6"><a class="btn" role="button" onclick="mostragiorni()"> SI </a></div></div> </div>'
          } else if (stringaOrario < 10.59) {
              document.getElementById("destra").style.backgroundColor = "#f2e7c3";
              document.getElementById("destra").style.color = "black";
              document.getElementById("destra").innerHTML += '<div class="alert alert-danger" id="avviso" style="padding: 10px; text-align: center;">' +
                  'Il ristorante aprirà alle 11, tra ';
              calcoloOre();
              document.getElementById("avviso").innerHTML += ' Vuoi effettuare la prenotazione per la giornata di oggi?' +
                  '<div class="row"><div class="col-6"><a href="carrello_prova6_controllo_data.html" class="btn" role="button">NO</a></div> ' +
                  '<div class="col-6"><a class="btn" role="button" onclick="modStringaOrario()"> SI </a></div></div> '
          } else {
              // se l'orario in cui un utente sta effettuando la prenotazione rientra negli orari di apertura può procedere con la prenotazione
              //document.getElementById("avviso").style.display = "none";
              document.getElementById("destra").style.backgroundColor = "#f2e7c3";
              document.getElementById("titoloFormSeleziona").innerHTML += 'Seleziona giorno e orario in cui desideri effettuare la prenotazione:';
              $( function() {
                  $( "#datepicker" ).datepicker({ minDate: 0, maxDate: "+0M +10D" }); // se un utente sta effettuando la prenotazione nel giorno stesso la data minima disponibile deve essere il giorno attuale
              } );
              document.getElementById("divGiorno").innerHTML += '<input type="text" id="datepicker" placeholder="Seleziona il giorno in cui prenotare">';
              //document.getElementById("divGiorno").innerHTML += '<input type="date" name="dataCalendar" value="' + dataoggi1 +'" id="dataCalendar2" min="' + dataoggi1 + '" max="' + datamassima +'"/>';
              document.getElementById("divOrario").innerHTML +='<select name="select_orario" class="form-select" id="orarid">';
              document.getElementById("orarid").innerHTML += '<option value="" disabled selected>Seleziona il tuo orario</option>';
              for(i; i < orari.length; i++) {
                  if(stringaOrario < parseFloat(orari[i])) { //controllo su ore successive a quella attuale
                      if (i !== orari.length-1) {
                          let orario_invio = orari[i] + '-' + orari[i+1];
                          //let ora_invio = orari[i];
                          document.getElementById("orarid").innerHTML += '<option value="' + orario_invio + '">' + orario_invio + '</option>';
                      }
                  }
              }
              document.getElementById("divOrario").innerHTML += '</select>';
              document.getElementById("orarid").addEventListener("change", stampa_orario);

          }
      }

      // funzione che si avvia SOLO se un utente chiede di prenotare un altro giorno
      function mostragiorni() {
    	  stringaOrario = 11.01;
          document.getElementById("avviso").style.display = "none";
          document.getElementById("siOno").style.display = "none";
          document.getElementById("destra").style.backgroundColor = "#f2e7c3";
          document.getElementById("titoloFormSeleziona").innerHTML += 'Seleziona giorno e orario in cui desideri effettuare la prenotazione:';
          $( function() {
              $( "#datepicker" ).datepicker({ minDate: +1, maxDate: "+0M +10D" });
          } );
          document.getElementById("divGiorno").innerHTML += '<input type="text" id="datepicker" placeholder="Seleziona giorno " >';
          //document.getElementById("divGiorno").innerHTML += '<input type="date" name="dataCalendar" value="' + dataoggi1 + '" id="dataCalendar2" min="' + dataoggi1 + '" max="' + datamassima + '"/>';
          document.getElementById("divOrario").innerHTML += '<select name="select_orario" class="form-select" id="orarid">';
          document.getElementById("orarid").innerHTML += '<option value="" disabled selected>Seleziona orario</option>';
          for (i; i < orari.length; i++) {
              if (i !== orari.length - 1) {
                  let orario_invio = orari[i] + '-' + orari[i + 1];
                  //let ora_invio = orari[i];
                  document.getElementById("orarid").innerHTML += '<option value="' + orario_invio + '">' + orario_invio + '</option>';
              }
          }
          document.getElementById("divOrario").innerHTML += '</select>';
          document.getElementById("orarid").addEventListener("change", stampa_orario);

      }
      let paypal=false;
      function stampa_orario() {
          if ((document.getElementById("datepicker").value === "") || (document.getElementById("datepicker").value  === "undefined")) {
              alert("Devi prima selezionare un giorno in cui effettuare la prenotazione!");
              document.getElementById("datepicker").focus();
          } else {
        	  
        	  
        	 
        	  
              let data_scelta = document.getElementById("datepicker").value;
              let orario_scelto = document.getElementById("orarid").value;
              
              
              document.getElementById("orario_finale").style.padding = "20px";
              document.getElementById("orario_finale").innerHTML = " ${Utente.nome}, confermi che ritirerai tuo ordine il ";
              document.getElementById("orario_finale").innerHTML += data_scelta;
              document.getElementById("orario_finale").innerHTML += " alle ore ";
              document.getElementById("orario_finale").innerHTML += orario_scelto;
              document.getElementById("orario_finale").innerHTML += " ? ";
              													/* '<button href="<spring:url value="/carrello/riepilogo" />"   type="button" id="pulsante1">Conferma orario di ritiro </button>' */
     	      document.getElementById("orario_finale").innerHTML += '<button id="pulsante1" >';
              document.getElementById("pulsante1").innerHTML      = '<a style="text-decoration:none;" href=' + '<spring:url value="/carrello/riepilogo/?data=' +data_scelta+ '&orario='+ orario_scelto + '"/>' +  '  onclick="paypalTrue()"  >Concludi e paga&nbsp;<i class="fa-brands fa-paypal fa-lg"></i></a></button>'
              
              }
              // orario_scelto E' LA VARIABILE DA SELEZIONARE E INVIARE AL DATABASE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          }
          
          function paypalTrue(){
        	  
        	  // simulazione pagamento paypal
        	 // paypal = true;
        	 // if(paypal){
          		window.open("http://paypal.com/signin?");
        	  
         // }

      }
      
      

</script>

</head>

<body onLoad="cambia()">

    
    

<div >
	<tiles:insertAttribute name="header"/>
	<tiles:insertAttribute name="content"/>
</div>
<tiles:insertAttribute name="footer"/>
</body>
</html>