<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Prescriptions Routes
|--------------------------------------------------------------------------
|
| Here is where you can register prescriptions routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('prescriptions')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Prescriptions module API endpoints.'
        ]);
    });
});
