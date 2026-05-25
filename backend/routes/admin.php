<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Admin Routes
|--------------------------------------------------------------------------
|
| Here is where you can register admin routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('admin')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Admin module API endpoints.'
        ]);
    });
});
