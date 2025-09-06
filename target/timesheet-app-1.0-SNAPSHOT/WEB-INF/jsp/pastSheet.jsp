<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.*, java.time.format.DateTimeFormatter" %>
<%@ page import="com.armaan.timesheet.app.dto.TimeSheet, com.armaan.timesheet.app.dto.State" %>

<%
    TimeSheet ts = (TimeSheet) session.getAttribute("timesheet");

    LocalDate monday = ts.getWkStart();
    LocalDate sunday = ts.getWkEnd();
    float[] values = new float[5];

    values[0] = ts.getMon() / 60.0f;
    values[1] = ts.getTue() / 60.0f;
    values[2] = ts.getWed() / 60.0f;
    values[3] = ts.getThu() / 60.0f;
    values[4] = ts.getFri() / 60.0f;

    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd-MM-yyyy");
    String weekStart = monday.format(fmt);
    String weekEnd = sunday.format(fmt);

    String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
    String[] dates = new String[5];
    for (int i = 0; i < 5; i++) {
        dates[i] = monday.plusDays(i).format(fmt);
    }

    State state = ts != null ? ts.getState() : null;

    String stateClass = "bg-gray-100 text-gray-700";
    if (state != null) {
        switch (state) {
            case APPROVED: stateClass = "bg-green-100 text-green-700"; break;
            case REJECTED: stateClass = "bg-red-100 text-red-700"; break;
            case SUBMITTED: stateClass = "bg-blue-100 text-blue-700"; break;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Timesheet</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-indigo-100 via-purple-100 to-pink-100 min-h-screen flex items-center justify-center">

    <div class="bg-white rounded-3xl shadow-2xl w-full max-w-2xl p-8">
        <h2 class="text-2xl font-extrabold text-center text-gray-800 mb-4">
            Timesheet for Week <%= weekStart %> to <%= weekEnd %>
        </h2>

        <div class="text-center mb-6">
            <span class="px-4 py-2 rounded-full text-sm font-semibold <%= stateClass %>">
                <%= state != null ? state : "UNKNOWN" %>
            </span>
        </div>

        <table class="w-full border border-gray-300 rounded-xl overflow-hidden shadow-sm">
            <thead>
                <tr class="bg-gradient-to-r from-indigo-500 to-purple-500 text-white">
                    <th class="py-3 px-4 text-left">Day</th>
                    <th class="py-3 px-4 text-left">Date</th>
                    <th class="py-3 px-4 text-center">Hours</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
                <% for (int i = 0; i < 5; i++) { %>
                <tr class="hover:bg-gray-50 transition">
                    <td class="py-2 px-4 font-medium text-gray-900"><%= days[i] %></td>
                    <td class="py-2 px-4 text-gray-700"><%= dates[i] %></td>
                    <td class="py-2 px-4 text-center">
                        <input type="number"
                               value="<%= values[i] %>"
                               readonly
                               class="border border-gray-300 rounded-md px-2 py-1 w-20 text-right bg-gray-100 text-gray-700">
                    </td>
                </tr>
                <% } %>

                <tr class="bg-gray-50">
                    <td class="py-2 px-4">Saturday</td>
                    <td class="py-2 px-4"><%= monday.plusDays(5).format(fmt) %></td>
                    <td class="py-2 px-4 text-center text-gray-500">Weekly Off</td>
                </tr>
                <tr class="bg-gray-50">
                    <td class="py-2 px-4">Sunday</td>
                    <td class="py-2 px-4"><%= sunday.format(fmt) %></td>
                    <td class="py-2 px-4 text-center text-gray-500">Weekly Off</td>
                </tr>
            </tbody>
        </table>

        <div class="text-center mt-8">
            <a href="viewPast"
               class="bg-indigo-600 text-white px-6 py-3 rounded-xl font-semibold shadow-md hover:bg-indigo-700 hover:shadow-lg transition">
                Go Back
            </a>
        </div>
    </div>

</body>
</html>
