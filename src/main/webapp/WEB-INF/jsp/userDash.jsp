<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-indigo-100 via-purple-100 to-pink-100 min-h-screen flex">

    <!-- Sidebar -->
    <aside class="w-64 bg-indigo-700 text-white flex flex-col">
        <div class="p-6 text-2xl font-extrabold border-b border-indigo-600">
            TimeLogger
        </div>
        <nav class="flex-1 p-4 space-y-4">
            <a href="addTime" class="block px-4 py-3 rounded-xl hover:bg-indigo-600 transition">➕ Add Timesheet</a>
            <a href="viewPast" class="block px-4 py-3 rounded-xl hover:bg-indigo-600 transition">📑 View Past Timesheets</a>
            <a href="logout" class="block px-4 py-3 rounded-xl hover:bg-red-600 transition">🚪 Logout</a>
        </nav>
        <div class="p-4 text-sm text-indigo-200 border-t border-indigo-600">
            © 2025 TimeLogger
        </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 p-10">
        <h1 class="text-4xl font-extrabold text-gray-800 mb-8">Welcome, User 👋</h1>

        <!-- Dashboard cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="bg-white shadow-2xl rounded-3xl p-8 hover:shadow-3xl transition">
                <h2 class="text-xl font-semibold text-gray-700 mb-3">Add Timesheet</h2>
                <p class="text-gray-500 mb-6">Log your hours for the current week.</p>
                <a href="addTime"
                   class="inline-block bg-indigo-600 text-white px-6 py-3 rounded-xl font-semibold hover:bg-indigo-700 transition-shadow shadow-md hover:shadow-lg">
                    Go
                </a>
            </div>

            <div class="bg-white shadow-2xl rounded-3xl p-8 hover:shadow-3xl transition">
                <h2 class="text-xl font-semibold text-gray-700 mb-3">View Past Timesheets</h2>
                <p class="text-gray-500 mb-6">Check your previous weeks’ timesheets.</p>
                <a href="viewPast"
                   class="inline-block bg-indigo-600 text-white px-6 py-3 rounded-xl font-semibold hover:bg-indigo-700 transition-shadow shadow-md hover:shadow-lg">
                    Go
                </a>
            </div>

            <div class="bg-white shadow-2xl rounded-3xl p-8 hover:shadow-3xl transition">
                <h2 class="text-xl font-semibold text-gray-700 mb-3">Logout</h2>
                <p class="text-gray-500 mb-6">End your session safely.</p>
                <a href="logout"
                   class="inline-block bg-red-600 text-white px-6 py-3 rounded-xl font-semibold hover:bg-red-700 transition-shadow shadow-md hover:shadow-lg">
                    Logout
                </a>
            </div>
        </div>

        <!-- Messages -->
        <div class="mt-6">
            <p class="text-red-500 text-sm">
                <%= (request.getAttribute("errMsg") != null) ? request.getAttribute("errMsg") : ""%>
            </p>
            <p class="text-green-500 text-sm">
                <%= (request.getAttribute("sucMsg") != null) ? request.getAttribute("sucMsg") : ""%>
            </p>
        </div>
    </main>
</body>
</html>
