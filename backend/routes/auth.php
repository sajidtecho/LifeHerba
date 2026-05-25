<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Auth Routes
|--------------------------------------------------------------------------
|
| Here is where you can register auth routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('auth')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Auth module API endpoints.'
        ]);
    });
});
