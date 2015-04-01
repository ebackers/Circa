<html>
    <head>
        <title> ${loggedUser.getFirstName()} ${loggedUser.getLastName()}</title>
        <link rel ="shortcut icon" href="img/CircaLogoIcon.ico">
        
        <meta charset="UTF-8">
        <script type = "text/javascript" src = "js/jquery-1.11.2.min.js">
        </script>
        <script type = "text/javascript" src = "js/header.js">
        </script>
        <script type = "text/javascript" src = "js/UserPage.js"></script>
        <link rel="stylesheet" type="text/css" 	media="all" href="css/header.css" />
        <link rel="stylesheet" type="text/css" 	media="all" href="css/UserPage.css" />

    </head>

    <body bgcolor="#f4f4f4">

        <!-- HEADER -->
        <div id = "header-whole">
            <div id = "header-temp">
            </div>
            <div id = "header">
                <form id = "header-left">
                    <input type = "text" placeholder = "Search for a Person / Event" class = "search-input"/>
                    <a href = "Result.jsp"><input type = "submit" class = "search-button" value = ">"/></a>
                </form>
                <div id = "header-right">
                    <a href = "UserPage.jsp" class = "text">${loggedUser.getFirstName()}</a>
                    <a href = "Clusters.jsp" class = "text">Clusters</a>
                    <a href = "Home.jsp" class = "text">Home</a>
                    <a href = "Logout" class = "text">Logout</a>
                </div>
            </div>
            <img src = "img\clusters\CircaLogo.png" class = "header-logo" />
        </div>
        <!-- END HEADER -->	 

        <div class = "profTop"><IMG class="profPic" src= "${loggedUser.getProfilePicture()}"/> <IMG class="profCover" src="img/home/coverfestival.jpg"/></div>

        <div class="infoDiv">
            <div class="infoText">${loggedUser.getFirstName()} ${loggedUser.getLastName()}</div>
            <div class="infoTitle">Clusters | Events</div> 
            <div class="infoTitleContent"> 126 || 7</div>

        </div>

        <div class="postDiv">
            
            <ul class = "tabs">
                <li><a href="#showEvents"><b>Events</b></a></li>
                <li><a href="#showSchedule"><b>Schedule</b></a></li>
            </ul>
            <div id = "showEvents" align = "center">
                <h3 class = "text-heading">Events of ${loggedUser.getFirstName()}<hr width = "70%"/></h3>
            </div>
            <div id = "showSchedule" align = "center">
                <h3 class = "text-heading">Schedule of ${loggedUser.getFirstName()}<hr width = "70%"/></h3>
                <input type = "date" class = "schedule-date"/>
            </div>
                
                
                
            <!--
            <div class = "postBar" >
                <div class="postBarTop"></div>
                <input type="text" class="postBarText" placeholder="Got a new event?"/>
                <div class="postBarBottom"><button type="button" class="postButton">Circulate</button></div>
            </div>

            <div class = "post">
                <IMG class = "postDP" src="img/logo.png"/>
                <div class="postOptions"><IMG class = "options" src="img/home/uncircled.png"/><IMG class = "options" src="img/home/recircle.png"/><IMG class = "options" src="img/home/ellipsis.png"/></div>
                <div class="textLinks"> Circa </div>
                <div class="postText"><p> Welcome to Circa! Your Social Planning Buddy WUBBY!</p></div>
                <div class = "postPhoto"><IMG class ="photo" src="img/home/weeeeeeeeeee.jpg"/></div>
                <div class ="postComment"><input type="text" placeholder="Write a comment..." class="textInput"/><IMG class ="commentPhoto" src="img/logo.png"/></div>
            </div>
            -->
            
        </div>
    </body>
</html>