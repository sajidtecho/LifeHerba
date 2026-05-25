<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Notifications Routes
|--------------------------------------------------------------------------
|
| Here is where you can register notifications routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('notifications')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Notifications module API endpoints.'
        ]);
    });
});
