<%@ page import="java.util.*, com.armaan.timesheet.app.dto.TimeSheet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<TimeSheet> timesheets = (List<TimeSheet>) session.getAttribute("timesheets");
    if (timesheets == null) {
        timesheets = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Approve Timesheets</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-rose-100 via-pink-100 to-fuchsia-100 min-h-screen flex flex-col items-center py-12">

    <h1 class="text-3xl font-extrabold mb-8 text-gray-800">✅ Approve Timesheets</h1>

    <div class="overflow-x-auto shadow-2xl rounded-3xl bg-white w-11/12 md:w-4/5">
        <table class="w-full text-sm text-left text-gray-700">
            <thead class="text-xs uppercase bg-gradient-to-r from-rose-600 to-fuchsia-600 text-white">
                <tr>
                    <th class="px-6 py-4">Week Start</th>
                    <th class="px-6 py-4">Week End</th>
                    <th class="px-6 py-4">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (timesheets.isEmpty()) {
                %>
                <tr>
                    <td colspan="3" class="px-6 py-6 text-center text-gray-500">
                        No timesheets awaiting approval.
                    </td>
                </tr>
                <%
                    } else {
                        for (TimeSheet ts : timesheets) {
                %>
                <tr class="border-b hover:bg-gray-50 transition">
                    <td class="px-6 py-4 font-medium text-gray-900"><%= ts.getWkStart() %></td>
                    <td class="px-6 py-4 font-medium text-gray-900"><%= ts.getWkEnd() %></td>
                    <td class="px-6 py-4">
                        <form action="selectApprove" method="post">
                            <input type="hidden" name="tsId" value="<%= ts.getId() %>" />
                            <button type="submit" 
                                    class="px-4 py-2 bg-green-600 text-white rounded-xl shadow-md hover:bg-green-700 hover:shadow-lg transition">
                                Review
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
           class="inline-block bg-rose-600 text-white px-6 py-3 rounded-xl font-semibold hover:bg-rose-700 transition-shadow shadow-md hover:shadow-lg">
            Go Back
        </a>
    </div>

</body>
</html>
