<%@ page import="java.util.*, com.armaan.timesheet.app.dto.TimeSheet, com.armaan.timesheet.app.dto.State" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<TimeSheet> timesheets = (List<TimeSheet>) session.getAttribute("timesheets");
    if (timesheets == null) {
        timesheets = new ArrayList<>();
    }
%>

<%!
    String getStateClass(State state) {
        if (state == null) return "bg-gray-100 text-gray-700";
        switch (state) {
            case APPROVED: return "bg-green-100 text-green-700";
            case REJECTED: return "bg-red-100 text-red-700";
            case SUBMITTED: return "bg-blue-100 text-blue-700";
            default: return "bg-gray-100 text-gray-700";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Past Timesheets</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-indigo-100 via-purple-100 to-pink-100 min-h-screen flex flex-col items-center py-12">

    <h1 class="text-3xl font-extrabold mb-8 text-gray-800">📑 Past Timesheets</h1>

    <div class="overflow-x-auto shadow-2xl rounded-3xl bg-white w-11/12 md:w-4/5">
        <table class="w-full text-sm text-left text-gray-700">
            <thead class="text-xs uppercase bg-gradient-to-r from-indigo-600 to-purple-600 text-white">
                <tr>
                    <th class="px-6 py-4">Week Start</th>
                    <th class="px-6 py-4">Week End</th>
                    <th class="px-6 py-4">State</th>
                    <th class="px-6 py-4">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (timesheets.isEmpty()) {
                %>
                <tr>
                    <td colspan="4" class="px-6 py-6 text-center text-gray-500">
                        No past timesheets available.
                    </td>
                </tr>
                <%
                    } else {
                        for (TimeSheet ts : timesheets) {
                            State st = ts.getState();
                %>
                <tr class="border-b hover:bg-gray-50 transition">
                    <td class="px-6 py-4 font-medium text-gray-900"><%= ts.getWkStart() %></td>
                    <td class="px-6 py-4 font-medium text-gray-900"><%= ts.getWkEnd() %></td>
                    <td class="px-6 py-4">
                        <span class="px-3 py-1 rounded-full text-xs font-semibold <%= getStateClass(st) %>">
                            <%= st != null ? st : "UNKNOWN" %>
                        </span>
                    </td>
                    <td class="px-6 py-4">
                        <form action="selectPast" method="post">
                            <input type="hidden" name="tsId" value="<%= ts.getId() %>" />
                            <button type="submit" 
                                    class="px-4 py-2 bg-indigo-600 text-white rounded-xl shadow-md hover:bg-indigo-700 hover:shadow-lg transition">
                                View
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <div class="text-center mt-8">
        <a href="dashboard"
           class="bg-indigo-600 text-white px-6 py-3 rounded-xl font-semibold shadow-md hover:bg-indigo-700 hover:shadow-lg transition">
            Go Back
        </a>
    </div>

</body>
</html>