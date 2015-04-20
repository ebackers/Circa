<%@page import="Database.CircaDatabase"%>
<%@page import="Classes.Comment"%>
<%@page import="Classes.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Classes.User"%>
<%@page import="Classes.Event"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<html>
    <head>
        <title>${eventDetails.getEventName()} | Circa</title>
        <link rel ="shortcut icon" href="img/CircaLogoIcon.ico">

        <!-- HEADER SCRIPT -->
        <script type = "text/javascript" src = "js/jquery-1.11.2.min.js">
        </script>
        <script type = "text/javascript" src = "js/header.js">
        </script>
        <script type = "text/javascript" src = "js/Event.js">
        </script>
        <link rel="stylesheet" type="text/css" 	media="all" href="css/header.css" />
        <!-- END HEADER -->

        <link rel="stylesheet" type="text/css" 	media="all" href="css/event.css" />

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body style = "margin: 0px;">
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

        <!-- EVENT -->
        <%
            //get Event details of event
            Event event = (Event) request.getSession().getAttribute("eventDetails");
            DateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy h:mm a");
            //get host
            User host = event.getHost();
            User loggedUser = (User) request.getSession().getAttribute("loggedUser");
            CircaDatabase db = CircaDatabase.getInstance();
        %>
        <div id = "event-header-div" align = "center">
            <img src = "<%=host.getProfilePicture()%>" alt = "<%=host.getFirstName()%> <%=host.getLastName()%>" class = "profile-pic"/>
            <img src = "img/event/event1.jpg" alt = "<%=host.getFirstName()%> <%=host.getLastName()%>" class = "event-header-img"/>
        </div>
        <h1 class = "event-title" align = "center" style = "color: #940000;"><%=event.getEventName()%></h1>
        <p class = "event-description" align = "center"><%=event.getDescription()%></p>
        <div id = "middle-div">
            <%
                if (loggedUser.getUserID() == host.getUserID()) {
            %>
            <div id = "event-container">
                <%
                    }
                %>
                <div id = "event-body-div" align = "center">
                    <p style = "color: #940000;"><b><%=dateFormat.format(event.getStartDate())%> - <%=dateFormat.format(event.getEndDate())%> | <%=event.getType()%> Event</b></p>
                    <p>Venue: <%=event.getVenue()%></p>
                    <p id = "attend-count"><%=event.getAttendingList().size()%> people are going</p>
                    <p>Hosted by <a href = "User?action=view&id=<%=host.getUserID()%>"><%=host.getFirstName()%> <%=host.getLastName()%></a></p>
                </div>
                <div id = "event-actions-div" align = "center">
                    <%
                        if (loggedUser.getUserID() != host.getUserID()) {
                            if (!db.isJoining(event.getEventID(), loggedUser.getUserID())) {
                                if (db.isInvited(event.getEventID(), loggedUser.getUserID())) {
                    %>
                    <div id ="request-join-message">
                        <%=event.getHost().getFirstName()%> invited you. What do you say?<br>
                        <form onsubmit = "return answerInvite(<%=event.getEventID()%>, <%=loggedUser.getUserID()%>, 'Approved', <%=event.getAttendingList().size()%>, '<%=event.getType()%>')">
                            <input type = "submit" class = "event-join" value = "Accept"/>
                        </form>
                        <form onsubmit = "return answerInvite(<%=event.getEventID()%>, <%=loggedUser.getUserID()%>, 'Rejected', <%=event.getAttendingList().size()%>, '<%=event.getType()%>')">
                            <input type = "submit" class = "event-join" value = "Decline"/>
                        </form>
                    </div>
                    <%
                    } else if (event.getType().equals("Closed")) {
                    %>

                    <%    if (db.isRequested(event.getEventID(), loggedUser.getUserID())) {
                    %>
                    <div id = "request-join-message">
                        You have already requested to join this event.
                    </div>
                    <%
                    } else {
                    %>
                    <div id = "request-join-message">
                        <form onsubmit = "return joinEvent(<%=event.getEventID()%>, '<%=event.getType()%>', <%=event.getAttendingList().size()%>)">
                            This is a closed event. You need to ask the host's permission to join!<br>
                            <input type = "submit" class = "event-join" value = "Request to Join"/>
                        </form>
                    </div>
                    <%
                        }
                    } else if (event.getType().equals("Public")) {
                    %>
                    <div id = "request-join-message">
                        <form onsubmit = "return joinEvent(<%=event.getEventID()%>, '<%=event.getType()%>', <%=event.getAttendingList().size()%>)">
                            <input type = "submit" class = "event-join" value = "Join"/>
                        </form>
                    </div>
                    <%
                    } else if (event.getType().equals("Private")) {
                    %>
                    <div id = "request-join-message">
                        This is a private event. Only invited users by the host can join. :(
                    </div>
                    <%
                        }
                        //if not joining
                    } else {
                    %>
                    <div id = "request-join-message">
                        <form onsubmit = "return leaveEvent(<%=event.getEventID()%>, '<%=event.getType()%>', <%=event.getAttendingList().size()%>)">
                            <input type = "submit" class = "event-join" value = "Leave"/>
                        </form>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <form action = "Event?action=edit" method = "post">
                        <input type = "submit" class = "event-join" value = "Edit Event Details"/>
                    </form>
                    <form action = "Event?action=delete&id=<%=event.getEventID()%>" onsubmit = "return deleteEvent()" method = "post">
                        <input type = "submit" class = "event-join" value = "Cancel Event"/>
                    </form>
                    <%
                        }
                    %>
                </div>
                <%
                    if (loggedUser.getUserID() == host.getUserID()) {
                %>
            </div>
            <div id = "invite-div">
                <h3 class = "invite-title" align = "center">Invite your Buddies!</h3>
                <div id = "invite-container">
                    <div id = "invited-div">
                        <h4 class = "invite-title">Invited: </h4><hr width = "90%">
                        <ul id = "invited-list">
                            <%
                                ArrayList<User> invitedList = event.getInvitedList();
                                for (User invited : invitedList) {
                            %>

                            <li id = "invited_<%=invited.getUserID()%>" class = "invite-item">
                                <form onsubmit = "return uninviteBuddy(<%=invited.getUserID()%>)">
                                    <img src = "<%=invited.getProfilePicture()%>" class = "invite-pic"/>
                                    <label for="invite-buddy"> <%=invited.getFirstName()%> <%=invited.getLastName()%></label>

                                    <input type = "submit" class = "remove-post" value = "x"/>
                                </form>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                    <div id = "invite-more-div">
                        <form onsubmit = "return inviteBuddies()" id = "invite-form">
                            <h4 class = "invite-title">Invite: </h4><hr width = "90%">

                            <ul id = "invite-list">
                                <%
                                    ArrayList<User> buddyList = loggedUser.getBuddyList();
                                    ArrayList<Integer> clustersView = event.getViewRestriction();
                                    for (User buddy : buddyList) {
                                        boolean isFound = false;
                                        for (int i = 0; i < clustersView.size() && !isFound; i++) {
                                            int cluster = clustersView.get(i);
                                            if (cluster == 0 || cluster == -1 || db.isClusterMember(buddy.getUserID(), cluster)) {
                                                if (!db.isInvited(event.getEventID(), buddy.getUserID())) {
                                %>
                                <li id = "buddy_<%=buddy.getUserID()%>" class = "invite-item">
                                    <input type = "checkbox" id = "invite-buddy" name = "invite-buddy" value = "<%=buddy.getUserID()%>"/>
                                    <img src = "<%=buddy.getProfilePicture()%>" class = "invite-pic"/>
                                    <label for="invite-buddy"> <%=buddy.getFirstName()%> <%=buddy.getLastName()%></label>
                                </li>
                                <%
                                                    isFound = true;
                                                }
                                            }
                                        }
                                    }
                                %>
                            </ul>
                            <input type = "submit" value = "Invite these Buddies!" class = "invite-submit"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%
            }

            if (event.getType().equals("Closed")) {
                if (loggedUser.getUserID() == host.getUserID()) {
        %>
        <!-- EVENT REQUESTS FOR HOST TO APPROVE-->
        <h3 align = "center" class = "event-comment-header">Requests to join your event</h3>
        <div id = "request-div">
            <ul id = "request-list">
                <%
                    ArrayList<User> requestList = event.getRequestList();

                    if (requestList.isEmpty()) {
                %>
                <li id = "no-request">
                    <h3 class = "empty-text" align = "center">Your event has no requests right now.</h3>
                </li>
                <%
                } else {
                %>

                <%
                    for (User requestor : requestList) {
                %>
                <li id = "request_<%=requestor.getUserID()%>" class = "request-item">
                    <div class = "request-container">
                        <a href = "User?action=view&id=<%=requestor.getUserID()%>">
                            <img src = "<%=requestor.getProfilePicture()%>" class = "request-prof-pic" title = "<%=requestor.getFirstName()%> <%=requestor.getLastName()%>"/>
                        </a><br>
                        <form onsubmit = "return answerRequest(<%=event.getEventID()%>, <%=requestor.getUserID()%>, 'Approved', <%=requestList.size()%>, <%=event.getAttendingList().size()%>)">
                            <input type = "submit" class = "request-button" value = "Approve"/>
                        </form>
                        <form onsubmit = "return answerRequest(<%=event.getEventID()%>, <%=requestor.getUserID()%>, 'Rejected', <%=requestList.size()%>, <%=event.getAttendingList().size()%>)">
                            <input type = "submit" class = "request-button" value = "Reject"/>
                        </form>
                    </div>
                </li>
                <%
                                }
                            }
                        }
                    }
                %>
            </ul>
        </div>
        <!-- POSTS and COMMENTS -->
        <%
            ArrayList<Post> postList = event.getPostList();
        %>
        <hr>
        <div id = "post-container"> 
            <div id = "input-post-div">
                <form onsubmit = "return addPost(<%=postList.size()%>)" id = "add-post">
                    <h4 class = "input-post-text">Post something about <%=event.getEventName()%>!</h4>
                    <hr width = "60%"/>
                    <textarea rows="5" cols = "40" class = "input-post-textarea" placeholder = "Say something about <%=event.getEventName()%>" name = "postText"></textarea>
                    <br><input type = "submit" class = "invite-submit" value = "Post"/>
                </form>
            </div>
            <h3 align = "center" class = "event-comment-header">Posts about "<%=event.getEventName()%>"</h3>
            <div id = "posts-div">
                <ul id = "post-list">
                    <%

                        if (postList.isEmpty()) {
                    %>
                    <li id = "no-post">
                        <h2 align = "center" class = "empty-text">There are no posts to display.</h2>
                    </li>
                    <%
                    } else if (!postList.isEmpty()) {
                        for (int i = 0; i < postList.size(); i++) {
                            if (!postList.get(i).isDeleted()) {
                                //get poster
                                User poster = postList.get(i).getPoster();
                                //get commentList
                                ArrayList<Comment> commentList = postList.get(i).getCommentList();
                    %>
                    <li id = "post_<%=postList.get(i).getPostID()%>">
                        <div id = "event-post-whole">
                            <div class = "event-post-div">
                                <%
                                    if (poster.getUserID() == loggedUser.getUserID()) {
                                %>
                                <form onsubmit = "return deletePost(<%=postList.get(i).getPostID()%>, <%=postList.size()%>)">
                                    <input type = "submit" class = "remove-post" value = "x"/>
                                </form>
                                <%
                                    }
                                %>
                                <img src = "<%=poster.getProfilePicture()%>" alt = "<%=poster.getFirstName()%> <%=poster.getLastName()%>" class = "post-pic"/>
                                <br>

                                <a href = "User?action=view&id=<%=poster.getUserID()%>">
                                    <b><%=poster.getFirstName()%> <%=poster.getLastName()%></b>
                                </a>

                                <%
                                    if (poster.getUserID() == loggedUser.getUserID()) {
                                %>
                                <div id = "edit-container">
                                    <button class = "edit-button">Edit This Post</button>

                                    <div class = "post-text-div"> 
                                        <%=postList.get(i).getPostText()%>
                                    </div>
                                    <div class = "edit-post-div" align = "center">
                                        <form id = "edit-form" onsubmit = "return editPost(<%=postList.get(i).getPostID()%>)">
                                            <textarea name = "postEditText" class = "edit-post-textarea" rows = "5" cols = "40"><%=postList.get(i).getPostText()%></textarea><br>
                                            <input type = "submit" value = "Submit" class = "post-edit-submit"/>
                                        </form>
                                    </div>
                                </div>
                                <%
                                } else {
                                %>
                                <%=postList.get(i).getPostText()%>
                                <%
                                    }
                                    if (!db.isLiked(postList.get(i).getPostID(), loggedUser.getUserID())) {
                                %>                      
                                <p align = "right" id = "comment-par"><%=postList.get(i).getLikeList().size()%> likes | <a class = "comment-link">Comment</a> <a onclick = "return likePost('like', <%=postList.get(i).getPostID()%>, <%=loggedUser.getUserID()%>, <%=postList.get(i).getLikeList().size()%>);
                                        return false;">Like</a></p>
                                    <%
                                    } else {
                                    %>
                                <p align = "right" id = "comment-par"><%=postList.get(i).getLikeList().size()%> likes | <a class = "comment-link">Comment</a> <a onclick = "return likePost('unlike', <%=postList.get(i).getPostID()%>, <%=loggedUser.getUserID()%>, <%=postList.get(i).getLikeList().size()%>);
                                        return false;">Unlike</a></p>
                                    <%
                                        }
                                    %>
                                <div class = "input-comment-div" align = "center">
                                    <form id = "add-comment" onsubmit = "return addComment(<%=postList.get(i).getPostID()%>, <%=commentList.size()%>)">
                                        <input type = "hidden" name = "curpage" value = "event" />
                                        <textarea name = "commentText" class = "comment-textarea"rows = "2" cols = "70" placeholder = "Comment something here!"></textarea>
                                        <br>
                                        <input type = "submit" class = "input-post-submit" value = "Comment!"/>
                                    </form>
                                </div>
                            </div>
                            <div class = "post-show-comment" align = "center">Show Comments</div>
                            <div class = "post-comments-whole">

                                <ul id = "comment-list">
                                    <%
                                        if (commentList.isEmpty()) {
                                    %>
                                    <li id = "comment-no">
                                        <h3 align = "center" class = "empty-text">This post has no comments yet.</h3>
                                    </li>
                                    <%
                                    } else {
                                    %>

                                    <%
                                        for (int j = 0; j < commentList.size(); j++) {
                                            //get commenter
                                            User commenter = commentList.get(j).getCommenter();
                                    %>
                                    <li id = "comment_<%=commentList.get(j).getCommentID()%>">
                                        <div class = "post-comment">
                                            <%
                                                if (commenter.getUserID() == loggedUser.getUserID()) {
                                            %>
                                            <form onsubmit = "return deleteComment(<%=commentList.get(j).getCommentID()%>)">
                                                <input type = "submit" class = "remove-post" value = "x"/>
                                            </form>
                                            <%
                                                }
                                            %>
                                            <img src = "<%=commenter.getProfilePicture()%>" alt = "<%=commenter.getFirstName()%> <%=commenter.getLastName()%>" class = "comment-pic"/>
                                            <p class = "event-post-text"><a href = "User?action=view&id=<%=commenter.getUserID()%>"><b>
                                                        <br><%=commenter.getFirstName()%> <%=commenter.getLastName()%></b></a> <%=commentList.get(j).getCommentText()%></p>
                                        </div>
                                    </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </li>
                    <%
                            }
                        }
                    %>

                </ul>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>
