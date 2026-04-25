//<!---is for toggle menu-->
 var MenuItems = document.getElementById("MenuItems");
    MenuItems.style.maxHeight = "0px";
    function  menutoggle(){
        if(MenuItems.style.maxHeight == "0px")
        {
            MenuItems.style.maxHeight = "200px";
            document.querySelector(".responsive_search_container").style.display="none"
        }
        else
        {
            MenuItems.style.maxHeight = "0px";
            document.querySelector(".responsive_search_container").style.display="flex"
        }
    }
    
    // id function
    function myFunction(id) {
    	document.getElementById("id").value=id;
    	document.getElementById('productForm').submit();
    	}
    	
    //<!------------is for product gallery---------------->
    var ProductImg = document.getElementById("ProductImg");
    var SmallImg = document.getElementsByClassName("small-img");

    SmallImg[0].onclick = function(){
        ProductImg.src=SmallImg[0].src;
    }
    SmallImg[1].onclick = function(){
        ProductImg.src=SmallImg[1].src;
    }
    SmallImg[2].onclick = function(){
        ProductImg.src=SmallImg[2].src;
    }
    SmallImg[3].onclick = function(){
        ProductImg.src=SmallImg[3].src;
    }
    
    //<!------------ alert---------------->

document.querySelector(".btn").addEventListener("click",()=>{
	alert("hello bro login",document.querySelector("#email").value)
})

// checkbox

function checked(sub1) {
  var myLayer = document.getElementById(sub1);
  var input = myLayer.childNodes[0];
  if (input.checked == true) {
    myLayer.disabled = "";
  } else {
    myLayer.disabled = "disabled";
  }
}