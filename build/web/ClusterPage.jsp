<%-- 
    Document   : ClusterPage
    Created on : Apr 5, 2015, 1:53:13 PM
    Author     : Arren Antioquia
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Classes.Post"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Database.CircaDatabase"%>
<%@page import="Classes.Event"%>
<%@page import="Classes.User"%>
<%@page import="Classes.Cluster"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>${clusterToProcess.getName()}  Cluster | Circa</title>
        <link rel ="shortcut icon" href="img/CircaLogoIcon.ico">

        <script type = "text/javascript" src = "js/jquery-1.11.2.min.js"></script>
        <script type = "text/javascript" src = "js/header.js"></script>
        <script type = "text/javascript" src = "js/ClusterPage.js"></script>
        <link rel="stylesheet" type="text/css" 	media="all" href="css/header.css" />
        <link rel="stylesheet" type="text/css" 	media="all" href="css/ClusterPage.css" />
    </head>
    <body bgcolor = "f4f4f4">
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
                    <a href = "User?action=view&id=${loggedUser.getUserID()}" class = "text">${loggedUser.getFirstName()}</a>
                    <a href = "Cluster" class = "text">Clusters</a>
                    <a href = "Home" class = "text">Home</a>
                    <a href = "Logout" class = "text">Logout</a>
                </div>
            </div>
            <img src = "img\clusters\CircaLogo.png" class = "header-logo" />
        </div>    
        <!-- END HEADER -->
        <div id = "cluster-main-panel">
            <div id = "cluster-info-panel">
                <div id = "cluster-name-div"><p id = "cluster-name">${clusterToProcess.getName()}</p></div>
                <ul id = "cluster-members-list">
                    <%  Cluster cluster = (Cluster) request.getSession().getAttribute("clusterToProcess");
                        CircaDatabase db = CircaDatabase.getInstance();
                        cluster.setMemberList(db.getClusterMembers(cluster.getClusterID()));
                        for (User clusterMember : cluster.getMemberList()) {
                    %>
                    <li class = "cluster-member">
                        <form class = "delete-cluster-member-form" action = "ViewCluster" method = "POST">
                            <input type = "hidden" name = "cluster-member-id" value = "<%=clusterMember.getUserID()%>" />
                            <input type = "hidden" name = "form-type" value = "delete-cluster-member" />
                            <input class = "delete-cluster-member-button" type = "image" src = "img/clusterpage/DeleteButtonSmall.png">
                        </form>
                        <a href = "User?action=view&id=<%=clusterMember.getUserID()%>">
                            <img src="<%=clusterMember.getProfilePicture()%>" class = "cluster-member-img" title = "<%=clusterMember.getFirstName()%> <%=clusterMember.getLastName()%>" width = "60px" height="60px" />
                        </a>
                    </li>
                    <%}%>
                </ul>
            </div>
            
            <div id = "cluster-post-panel">
                <%
                    User user = (User) request.getSession().getAttribute("loggedUser");
                    
                    ArrayList<Event> viewableEvents = new ArrayList<>();
                    
                    for(Event event : user.getEventList()){
                        if(db.isViewableToCluster(event.getEventID(), cluster.getClusterID())){
                            event.setPostList(db.getPosts(event.getEventID()));
                            viewableEvents.add(event);
                        }
                    }
                    if(viewableEvents.size() != 0){
                        for(Event event : viewableEvents){
                            for(Post post : event.getPostList()){
                %>
                <div class = "post-div">
                    <div class = "post-container">
                        <a href = "User?action=view&id=<%=post.getPoster().getUserID()%>">
                            <img src ="<%=post.getPoster().getProfilePicture()%>" class ="post-poster-img" height = "50px" width="50px"/>
                        </a>

                        <a href = "User?action=view&id=<%=post.getPoster().getUserID()%>" class = "post-poster-name-link">
                            <p class = "post-poster-name"><%=post.getPoster().getFirstName()%> <%=post.getPoster().getLastName()%></p>
                        </a>

                        <a href = "Event?action=view&id=<%=post.getEvent().getEventID()%>" class = "post-event-name-link">
                            <p class = "post-event-name"><%=post.getEvent().getEventName()%></p>
                        </a>

                        <p class = "post-text"><%=post.getPostText()%></p>
                    </div>
                </div>
                <%
                            }
                        }
                    }
                    else{
                %>
                <div class = "post-div">
                    <div id = "post-no-post-container-div">
                        <img src ="img/clusterpage/SorryIcon.png" id ="post-no-post-img" height = "100px" width="100px"/>
                        <p id = "post-no-post-text">Sorry, no post to show.</p>
                    </div>
                </div>
                <%  }
                %>
            </div>
            
            <div id = "cluster-other-panel">
                <%  if(viewableEvents.size() != 0){
                %>
                <div id = "cluster-other-event-panel">
                    <div id = "event-tag-div">
                        <p id = "event-tag">Events</p>
                    </div>

                    <ul id = "cluster-event-list">
                        <%  user.setEventList(db.getEvents(user.getUserID()));
                            for (Event event : viewableEvents) {
                                SimpleDateFormat ddMMMMyyFormat = new SimpleDateFormat("MMM dd, yyyy");
                                String strDate = ddMMMMyyFormat.format(event.getStartDate());
                        %>
                        <li class = "cluster-event-item">
                            <a href = "Event?action=view&id=<%=event.getEventID()%>">
                                <img src = "<%=event.getEventPicture()%>" class = "cluster-event-pic" title = "<%=event.getEventName()%>" width = "40px" height="40px" />
                            </a>
                            <div class = "cluster-event-info-div">
                                <a href = "Event?action=view&id=<%=event.getEventID()%>" class = "cluster-name-link">
                                    <p class = "cluster-event-name"><%=event.getEventName()%></p>
                                </a>
                                <p class = "cluster-event-info"><%=event.getVenue()%> - <%=strDate%></p>
                            </div>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </div>
                <%  }
                    user.setBuddyList(db.getUserBuddies(user.getUserID()));
                    ArrayList<User> addableBuddyToCluster = new ArrayList<>();
                    for(User buddy : user.getBuddyList()){
                        if(!db.isClusterMember(buddy.getUserID(), cluster.getClusterID())){
                            addableBuddyToCluster.add(buddy);
                        }
                    }
                    
                    if(addableBuddyToCluster.size() != 0){
                %>
                <div id = "cluster-other-addmember-panel">
                    <div id = "addmember-tag-div">
                        <p id = "addmember-tag">Add Members</p>
                    </div>
                    <div id = "add-member-div">
                        <form id = "addmember-form" action = "ViewCluster" method="POST">
                            <ul id = "cluster-addmember-list">
                                <%  for(User buddy : addableBuddyToCluster){
                                %>
                                <li class = "new-member-item">
                                    <input type = "checkbox" id = "new-member" name = "new-member" value = "<%=buddy.getUserID()%>"/>
                                    <label for="new-member"><%=buddy.getFirstName()%> <%=buddy.getLastName()%></label>
                                </li>
                                <%
                                    }
                                %>
                            </ul>
                            <input type = "hidden" name = "form-type" value = "add-cluster-member" />
                            <input type = "submit" id = "addmember-submit-button" value = "Add to Cluster"/>
                        </form>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </body>
</html>