<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Appointments Routes
|--------------------------------------------------------------------------
|
| Here is where you can register appointments routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('appointments')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Appointments module API endpoints.'
        ]);
    });
});
