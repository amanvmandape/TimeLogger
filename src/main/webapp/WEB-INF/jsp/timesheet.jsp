<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.*, java.time.format.DateTimeFormatter" %>
<%@ page import="com.armaan.timesheet.app.dto.TimeSheet" %>

<%
    TimeSheet ts = (TimeSheet) session.getAttribute("timesheet");

    LocalDate monday;
    LocalDate sunday;
    float[] values = new float[5];
    if (ts != null && ts.getWkStart() != null && ts.getWkEnd() != null) {
        monday = ts.getWkStart();
        sunday = ts.getWkEnd();

        values[0] = ts.getMon() / 60.0f;
        values[1] = ts.getTue() / 60.0f;
        values[2] = ts.getWed() / 60.0f;
        values[3] = ts.getThu() / 60.0f;
        values[4] = ts.getFri() / 60.0f;
    } else {
        LocalDate today = LocalDate.now();
        monday = today.with(DayOfWeek.MONDAY);
        sunday = today.with(DayOfWeek.SUNDAY);
    }

    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd-MM-yyyy");
    String weekStart = monday.format(fmt);
    String weekEnd = sunday.format(fmt);

    boolean isFriday = (LocalDate.now().getDayOfWeek() == DayOfWeek.FRIDAY);

    String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
    String[] dates = new String[5];
    for (int i = 0; i < 5; i++) {
        dates[i] = monday.plusDays(i).format(fmt);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Weekly Timesheet</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-indigo-100 via-purple-100 to-pink-100 min-h-screen flex items-center justify-center">

    <div class="bg-white p-10 rounded-3xl shadow-2xl w-full max-w-4xl">

        <!-- Heading -->
        <h2 class="text-3xl font-extrabold text-center text-gray-800 mb-4">
            Timesheet for Week <%= weekStart %> to <%= weekEnd %>
        </h2>

        <!-- Optional state display (if you want to show approval status) -->
        <%-- Example: 
        <div class="text-center mb-6">
            <span class="px-4 py-2 rounded-full text-sm font-semibold bg-gray-100 text-gray-700">SUBMITTED</span>
        </div> 
        --%>

        <form action="addTime" method="post" class="space-y-6">
            <input type="hidden" name="weekStart" value="<%= monday %>">
            <input type="hidden" name="weekEnd" value="<%= sunday %>">

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
                            <input type="number" name="<%= days[i].substring(0,3).toLowerCase() %>"
                                   min="0" max="24" step="0.5"
                                   value="<%= values[i] %>"
                                   class="border border-gray-300 rounded-md px-2 py-1 w-20 text-right bg-gray-100 text-gray-700 focus:ring-2 focus:ring-indigo-500 focus:outline-none transition">
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

            <!-- Buttons with consistent spacing and theme -->
            <div class="flex justify-center gap-4 mt-6">
                <button type="submit" name="action" value="save"
                        class="bg-green-600 text-white px-5 py-2 rounded-xl font-semibold shadow-md hover:bg-green-700 hover:shadow-lg transition">
                    Save
                </button>

                <button type="submit" name="action" value="submit"
                        <%= isFriday ? "class='px-5 py-2 rounded-xl font-semibold shadow-md bg-blue-600 text-white hover:bg-blue-700 hover:shadow-lg transition'" : "class='px-5 py-2 rounded-xl font-semibold shadow-md opacity-50 cursor-not-allowed bg-gray-400'"%>
                        <%= isFriday ? "" : "disabled"%>>
                    Submit
                </button>

                <a href="dashboard"
                   class="bg-purple-600 text-white px-6 py-2 rounded-xl font-semibold shadow-md hover:bg-purple-700 hover:shadow-lg transition flex items-center justify-center">
                    Go Back
                </a>
            </div>

            <p class="text-red-500 text-sm text-center mt-4">
                <%= (request.getAttribute("errMsg") != null) ? request.getAttribute("errMsg") : "" %>
            </p>
        </form>
    </div>

</body>
</html>
