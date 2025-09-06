<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login to TimeLogger</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-r from-indigo-100 via-purple-100 to-pink-100 flex items-center justify-center min-h-screen">

    <div class="bg-white p-10 rounded-3xl shadow-2xl w-96">
        <h1 class="text-3xl font-extrabold text-center text-gray-800 mb-8">TimeLogger Login</h1>

        <form action="login" method="post" class="space-y-6">
            <div>
                <label class="block text-gray-700 font-medium mb-1">Username</label>
                <input type="text" name="username" required
                       class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition" />
            </div>

            <div>
                <label class="block text-gray-700 font-medium mb-1">Password</label>
                <input type="password" name="password" required
                       class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition" />
            </div>

            <button type="submit"
                    class="w-full bg-indigo-600 text-white py-3 rounded-xl font-semibold hover:bg-indigo-700 transition-shadow shadow-md hover:shadow-lg">
                Login
            </button>

            <p class="text-red-500 text-sm text-center mt-2">
                <%= (request.getAttribute("errMsg") != null) ? request.getAttribute("errMsg") : ""%>
            </p>
        </form>
    </div>

</body>
</html>
